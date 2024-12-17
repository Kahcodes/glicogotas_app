import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina3.dart'; // Importar a página anterior
import 'package:glicogotas_app/Livro/pagina5.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:glicogotas_app/main.dart'; // Certifique-se de que o caminho esteja correto
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pagina4Page extends StatefulWidget {
  const Pagina4Page({super.key});

  @override
  Pagina4PageState createState() => Pagina4PageState();
}

class Pagina4PageState extends State<Pagina4Page> with RouteAware {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Função para reproduzir o áudio
  Future<void> _playAudio() async {
    await _audioPlayer
        .stop(); // Garante que qualquer áudio anterior seja parado
    await _audioPlayer.play(AssetSource('audio/audiopag4.mp3'));
  }

  // Atualiza o áudio com base no estado do Provider
  Future<void> _updateAudioStream(BuildContext context) async {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: true);

    if (configuracoesProvider.soundOn) {
      _audioPlayer.resume();
    } else {
      _audioPlayer.pause();
    }
  }

  Future<void> _saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_page', page);
  }

  @override
  void initState() {
    super.initState();
    _playAudio(); // Inicia o áudio ao carregar a página
    _saveCurrentPage(4); // Salva que o usuário está na Página 1
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this); // Desinscreve-se ao sair
    _audioPlayer.stop(); // Para o áudio ao sair
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioPlayer.stop(); // Para o áudio ao ir para outra página
  }

  @override
  void didPopNext() {
    _playAudio(); // Reinicia o áudio ao voltar para esta página
  }

  @override
  Widget build(BuildContext context) {
    _updateAudioStream(
        context); // Atualiza o estado do áudio com base no Provider

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFfffcf3),
      body: Stack(
        children: [
          // Fundo da página
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundopaglivro.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Elementos visuais principais
          Positioned(
            top: size.height * 0.25, // Ajuste para mover para baixo
            left: -size.width * 0.1,
            child: SvgPicture.asset(
              'assets/images/lita-pancreas.svg',
              width: size.width * 0.7,
              height: size.height * 0.6,
            ),
          ),
          Positioned(
            top: size.height * 0.16,
            right: size.width * 0.04,
            child: SvgPicture.asset(
              'assets/images/balão-page4.svg',
              width: size.width * 0.9,
            ),
          ),

          // Botão Home
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.home_rounded,
                color: Color(0xFF265F95),
              ),
              onPressed: () {
                _audioPlayer.stop(); // Para o áudio ao voltar à tela inicial
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaHome()),
                );
              },
            ),
          ),

          // Botão Configurações
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.settings,
                color: Color(0xFF265F95),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ConfigDialog(); // Chama o diálogo de configurações
                  },
                );
              },
            ),
          ),

          // Botão para voltar
          Positioned(
            bottom: size.height * 0.08,
            left: 20, // Ajuste para posicionar próximo da borda
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 48, // Tamanho consistente com outras páginas
                color: Color(0xFF265F95),
              ),
              onPressed: () {
                _audioPlayer.stop(); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina3Page()),
                ); // Navega para a página anterior
              },
            ),
          ),

          Positioned(
            bottom: size.height * 0.08,
            right: 20, // Ajuste para posicionar próximo da borda
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 48, // Tamanho consistente com outras páginas
                color: Color(0xFF265F95),
              ),
              onPressed: () {
                _audioPlayer.stop(); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina5Page()),
                ); // Navega para a próxima página
              },
            ),
          ),
        ],
      ),
    );
  }
}
