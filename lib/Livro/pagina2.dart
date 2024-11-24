import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina3.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:audioplayers/audioplayers.dart';

class Pagina2Page extends StatefulWidget {
  const Pagina2Page({super.key});

  @override
  Pagina2PageState createState() => Pagina2PageState();
}

class Pagina2PageState extends State<Pagina2Page> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Função para reproduzir o áudio
  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('audio/audiopag2.mp3'));
  }

  // Função para parar o áudio
  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  void initState() {
    super.initState();
    _playAudio(); // Inicia o áudio ao carregar a página
  }

  @override
  void dispose() {
    _stopAudio(); // Para o áudio ao sair da página
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

          // Lita falando
          Positioned(
            top: size.height * 0.30,
            right: size.width * 0.15,
            child: SvgPicture.asset(
              'assets/images/lita-falando.svg',
              height: size.height * 0.6,
            ),
          ),

          // Balão de fala
          Positioned(
            top: size.height * 0.2,
            left: size.width * 0.02,
            right: size.width * 0.03,
            child: SvgPicture.asset(
              'assets/images/balão-page2.svg',
              width: size.width * 0.80,
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
                _stopAudio(); // Para o áudio ao voltar à tela inicial
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

          // Botão invisível para voltar (lado esquerdo)
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                _stopAudio(); // Para o áudio ao navegar
                Navigator.pop(context); // Volta para a página anterior
              },
              child: Container(
                width: size.width * 0.45,
                height: size.height,
                color: Colors.transparent, // Invisível mas funcional
              ),
            ),
          ),

          // Botão invisível para avançar (lado direito)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                _stopAudio(); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Pagina3Page()), // Navega para a próxima página
                );
              },
              child: Container(
                width: size.width * 0.45,
                height: size.height,
                color: Colors.transparent, // Invisível mas funcional
              ),
            ),
          ),
        ],
      ),
    );
  }
}
