import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina1.dart';
import 'package:glicogotas_app/Livro/pagina4.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:audioplayers/audioplayers.dart'; // Importa a biblioteca para áudio

class Pagina3Page extends StatefulWidget {
  const Pagina3Page({super.key});

  @override
  Pagina3PageState createState() =>
      Pagina3PageState(); // Agora a classe é pública
}

class Pagina3PageState extends State<Pagina3Page> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Instancia o player de áudio
  bool _isPlaying = false; // Estado para controle de áudio

  @override
  void initState() {
    super.initState();

    // Definindo o tempo para 5 segundos antes de mudar de página
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              Pagina4Page(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });

    // Tocar o áudio quando a página for carregada
    _playAudio();
  }

  // Função para reproduzir o áudio
  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('audio/audiopag3.mp3'));
  }

  // Função para pausar o áudio
  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  // Função para alternar entre play e pause
  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _pauseAudio(); // Pausa o áudio
    } else {
      await _playAudio(); // Inicia o áudio
    }
    setState(() {
      _isPlaying = !_isPlaying; // Alterna o estado de áudio
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFfffcf3),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundopaglivro.svg',
              fit: BoxFit.cover,
            ),
          ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaHome()),
                );
              },
            ),
          ),
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
          Positioned(
            top: size.height * 0.2,
            left: -size.width * 0.1,
            child: SvgPicture.asset(
              'assets/images/lita-pancreas.svg',
              width: size.width * 0.7,
              height: size.height * 0.6,
            ),
          ),
          Positioned(
            top: size.height * 0.15,
            left: size.width * 0.1,
            child: SvgPicture.asset(
              'assets/images/balão-page3.svg',
              width: size.width * 0.8,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(color: Color(0xFFFCB44E)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-voltar-laranja.svg',
                      width: 60,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Pagina1Page()),
                      );
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-som-laranja.svg',
                      width: 60,
                    ),
                    onPressed:
                        _toggleAudio, // Chama a função para alternar o áudio
                  ),
                  const SizedBox(
                    width: 60, // Espaço para manter o layout equilibrado
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
