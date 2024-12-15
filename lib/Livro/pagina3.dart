import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina4.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:glicogotas_app/main.dart'; // Importa o routeObserver
import 'package:provider/provider.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';

class Pagina3Page extends StatefulWidget {
  const Pagina3Page({super.key});

  @override
  Pagina3PageState createState() => Pagina3PageState();
}

class Pagina3PageState extends State<Pagina3Page> with RouteAware {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playAudio() async {
    await _audioPlayer
        .stop(); // Garante que qualquer áudio anterior seja parado
    await _audioPlayer.play(AssetSource('audio/audiopag3.mp3'));
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
    routeObserver.subscribe(
        this,
        ModalRoute.of(context) as PageRoute<
            dynamic>); // Inscreve o observador para mudanças de rota
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this); // Desinscreve o observador
    _audioPlayer.stop(); // Para o áudio ao sair da página
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioPlayer.stop(); // Para o áudio ao ir para a próxima página
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

          // Imagem da Lita
          Positioned(
            top: size.height * 0.25, // Ajuste para mover para baixo
            left: -size.width * 0.1,
            child: SvgPicture.asset(
              'assets/images/lita-pancreas.svg',
              width: size.width * 0.7,
              height: size.height * 0.6,
            ),
          ),

          // Balão de fala
          Positioned(
            top: size.height * 0.22,
            left: size.width * 0.01,
            right: size.width * 0.03,
            child: SvgPicture.asset(
              'assets/images/balão-page3.svg',
              width: size.width * 0.80,
            ),
          ),

          // Ícone Home
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

          // Ícone Configurações
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
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: () {
                _audioPlayer.stop(); // Para o áudio ao navegar
                Navigator.pop(context); // Voltar para a página anterior
              },
              child: Container(
                padding: const EdgeInsets.all(16), // Aumenta a área clicável
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent, // Mantém a transparência
                ),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 24, // Aumenta o tamanho do ícone
                  color: Color(0xFF265F95),
                ),
              ),
            ),
          ),

          // Botão para avançar
          Align(
            alignment: Alignment.bottomRight, // Ajuste para mais para cima
            child: GestureDetector(
              onTap: () {
                _audioPlayer.stop(); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina4Page()),
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
                  size: 24, // Aumenta o tamanho do ícone
                  color: Color(0xFF265F95),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
