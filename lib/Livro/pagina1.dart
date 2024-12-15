import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/capa.dart';
import 'package:glicogotas_app/Livro/pagina2.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:glicogotas_app/main.dart'; // Importa o routeObserver
import 'package:provider/provider.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';

class Pagina1Page extends StatefulWidget {
  const Pagina1Page({super.key});

  @override
  State<Pagina1Page> createState() => _Pagina1PageState();
}

class _Pagina1PageState extends State<Pagina1Page> with RouteAware {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Função para reproduzir o áudio
  Future<void> _playAudio() async {
    await _audioPlayer.stop(); // Garante que o áudio anterior seja parado
    await _audioPlayer.play(AssetSource('audio/audiopag1.mp3'));
  }

  Future<void> _updateAudioStream(BuildContext context) async {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: true);
    if (configuracoesProvider.soundOn) {
      _audioPlayer.resume();
    } else {
      _audioPlayer.pause();
    }
  }

  @override
  void initState() {
    super.initState();
    _playAudio(); // Inicia o áudio ao carregar a página
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioPlayer.stop(); // Para o áudio ao sair da página
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioPlayer.stop(); // Para o áudio ao navegar para a próxima página
  }

  @override
  void didPopNext() {
    _playAudio(); // Reinicia o áudio ao voltar para esta página
  }

  @override
  Widget build(BuildContext context) {
    _updateAudioStream(context);
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

          // Personagem Lita
          Positioned(
            top: size.height * 0.25,
            right: size.width * 0.15,
            child: SvgPicture.asset(
              'assets/images/lita.svg',
              height: size.height * 0.6,
            ),
          ),

          // Balão de fala
          Positioned(
            top: size.height * 0.05,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: SvgPicture.asset(
              'assets/images/balão-duplo.svg',
              width: size.width * 1.2,
            ),
          ),

          // Botão de navegação anterior
          Align(
            alignment:
                Alignment.bottomLeft, // Alinhado para a parte inferior esquerda
            child: GestureDetector(
              onTap: () {
                _audioPlayer
                    .stop(); // Para o áudio ao ir para a página anterior
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CapaPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16), // Aumenta a área clicável
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent, // Mantém a transparência
                ),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 24, // Aumenta o tamanho do ícone se desejar
                  color: Color(0xFF265F95), // Cor do ícone
                ),
              ),
            ),
          ),

          // Botão de navegação próxima
          Align(
            alignment:
                Alignment.bottomRight, // Alinhado para a parte inferior direita
            child: GestureDetector(
              onTap: () {
                _audioPlayer.stop(); // Para o áudio ao ir para a próxima página
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina2Page()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16), // Aumenta a área clicável
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent, // Mantém a transparência
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 24, // Aumenta o tamanho do ícone se desejar
                  color: Color(0xFF265F95), // Cor do ícone
                ),
              ),
            ),
          ),

          // Ícone Home (por cima dos botões invisíveis)
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

          // Ícone Configurações (por cima dos botões invisíveis)
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
                    return const ConfigDialog();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
