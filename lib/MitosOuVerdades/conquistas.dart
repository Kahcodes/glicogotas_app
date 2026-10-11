import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConquistaMitos {
  final String id, titulo, descricao, imagem;
  const ConquistaMitos(this.id, this.titulo, this.descricao, this.imagem);
}

const conquistasMitos = <ConquistaMitos>[
  ConquistaMitos('primeira', '🔎 Caçador de Mitos', 'Respondeu seu primeiro Mito ou Verdade.', 'assets/images/lita-pensa.svg'),
  ConquistaMitos('cinco', '🧠 GlicoExpert', 'Acertou 5 perguntas.', 'assets/images/Betinho-ensinando.svg'),
  ConquistaMitos('sequencia', '🔥 Tá sabendo tudo!', 'Acertou 3 seguidas.', 'assets/images/pumps-person.svg'),
  ConquistaMitos('alimentacao', '🍎 Mestre da Alimentação', 'Completou frutas, doces, mel e dieta.', 'assets/images/perso-canetto.svg'),
  ConquistaMitos('atleta', '🏃 GlicoAtleta', 'Completou atividade física.', 'assets/images/betinho-person.svg'),
  ConquistaMitos('todos', '🏆 Guardião do Conhecimento', 'Completou todos os Mitos e Verdades.', 'assets/images/Lita-heroina.svg'),
];

class ConquistasMitosService {
  ConquistasMitosService._();
  static final instance = ConquistasMitosService._();
  static const _key = 'mitos_conquistas_v1';
  static const temas = {'causas', 'doces', 'frutas', 'dieta', 'mel', 'fisico'};
  Future<void> _fila = Future<void>.value();

  // Uma fila evita que duas gravações simultâneas apaguem o progresso.
  Future<List<ConquistaMitos>> registrar({String? pergunta, bool? correta, String? temaConcluido}) {
    final operacao = _fila.then((_) async {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      final dados = raw == null ? <String, dynamic>{} : jsonDecode(raw) as Map<String, dynamic>;
      final acertos = Set<String>.from(dados['acertos'] ?? <String>[]);
      final concluidos = Set<String>.from(dados['concluidos'] ?? <String>[]);
      final liberadas = Set<String>.from(dados['liberadas'] ?? <String>[]);
      final sequencia = Set<String>.from(dados['sequenciaPerguntas'] ?? <String>[]);
      final antes = Set<String>.from(liberadas);
      if (pergunta != null && correta != null) {
        liberadas.add('primeira');
        if (correta) {
          acertos.add(pergunta);
          sequencia.add(pergunta);
        } else {
          sequencia.clear();
        }
        if (acertos.length >= 5) liberadas.add('cinco');
        if (sequencia.length >= 3) liberadas.add('sequencia');
      }
      if (temaConcluido != null && temas.contains(temaConcluido)) concluidos.add(temaConcluido);
      if (concluidos.containsAll({'frutas', 'doces', 'mel', 'dieta'})) liberadas.add('alimentacao');
      if (concluidos.contains('fisico')) liberadas.add('atleta');
      if (concluidos.containsAll(temas)) liberadas.add('todos');
      final salvo = await prefs.setString(_key, jsonEncode({
        'acertos': acertos.toList(), 'concluidos': concluidos.toList(),
        'liberadas': liberadas.toList(), 'sequenciaPerguntas': sequencia.toList(),
      }));
      if (!salvo) throw StateError('Não foi possível salvar as conquistas.');
      return conquistasMitos.where((c) => liberadas.contains(c.id) && !antes.contains(c.id)).toList();
    });
    _fila = operacao.then<void>((_) {}, onError: (Object error, StackTrace stack) {});
    return operacao;
  }

  Future<Set<String>> carregar() async {
    await _fila;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return <String>{};
    return Set<String>.from((jsonDecode(raw) as Map<String, dynamic>)['liberadas'] ?? <String>[]);
  }
}

// Aguarda o som de resposta e cancela a escuta ao terminar.
Future<void> tocarSomRespostaMitos(AudioPlayer player, bool correta) async {
  final terminou = Completer<void>();
  final escuta = player.onPlayerComplete.listen((_) {
    if (!terminou.isCompleted) terminou.complete();
  });
  try {
    await player.play(AssetSource(
      correta ? 'sounds/acerto.mp3' : 'sounds/erro.mp3',
    ));
    await terminou.future.timeout(const Duration(seconds: 10), onTimeout: () {});
  } catch (error) {
    debugPrint('Não foi possível tocar o som da resposta: $error');
  } finally {
    await escuta.cancel();
  }
}

// Um som por evento, mesmo quando várias conquistas são liberadas juntas.
Future<void> _tocarSomConquista() async {
  AudioPlayer? player;
  try {
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool('soundOn') ?? true) ||
        !(prefs.getBool('musicOn') ?? true)) {
      return;
    }
    final audio = AudioPlayer();
    player = audio;
    final terminou = audio.onPlayerComplete.first.timeout(
      const Duration(seconds: 30), onTimeout: () {},
    );
    await audio.setVolume(1.0);
    await audio.play(AssetSource('sounds/conquista_desbloqueada.mp3'));
    await terminou;
  } catch (error) {
    // Uma falha no som não impede a conquista de aparecer ou ser salva.
    debugPrint('Não foi possível tocar o som da conquista: $error');
  } finally {
    await player?.dispose();
  }
}

Future<void> avisarConquistas(
  BuildContext context,
  Future<List<ConquistaMitos>> operacao, {
  Future<void>? esperarSom,
}) async {
  try {
    final novas = await operacao;
    if (esperarSom != null) {
      await esperarSom;
    }
    if (!context.mounted) return;
    if (novas.isNotEmpty) _tocarSomConquista();
    for (final conquista in novas) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color(0xFF680DDF),
        duration: const Duration(seconds: 4),
        content: Row(children: [
          SvgPicture.asset(conquista.imagem, width: 48, height: 48),
          const SizedBox(width: 12),
          Expanded(child: Text('Conquista desbloqueada!\n${conquista.titulo}')),
        ]),
      ));
    }
  } catch (_) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Não foi possível salvar a conquista. Tente novamente.'),
    ));
  }
}

Future<void> mostrarConquistasMitos(BuildContext context) async {
  Set<String> liberadas;
  try {
    liberadas = await ConquistasMitosService.instance.carregar();
  } catch (_) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Não foi possível carregar as conquistas.')));
    return;
  }
  if (!context.mounted) return;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFFFFF3F6),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (context) => SafeArea(child: SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75,
      child: Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          Expanded(child: Text('Minhas conquistas (${liberadas.length}/6)', style: GoogleFonts.chewy(fontSize: 23, color: const Color(0xFF680DDF)))),
          IconButton(tooltip: 'Fechar', onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
        ])),
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          itemCount: conquistasMitos.length,
          itemBuilder: (context, index) {
            final c = conquistasMitos[index];
            final aberta = liberadas.contains(c.id);
            return Card(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
              Opacity(opacity: aberta ? 1 : 0.35, child: SvgPicture.asset(c.imagem, width: 64, height: 72)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(c.titulo, style: GoogleFonts.chewy(fontSize: 19, color: const Color(0xFF5A2D82))),
                Text(c.descricao),
                const SizedBox(height: 4),
                Text(aberta ? 'Desbloqueada!' : 'Ainda bloqueada', style: TextStyle(color: aberta ? Colors.green.shade800 : Colors.grey.shade700)),
              ])),
              Icon(aberta ? Icons.check_circle : Icons.lock_outline, color: aberta ? Colors.green : Colors.grey),
            ])));
          },
        )),
      ]),
    )),
  );
}
