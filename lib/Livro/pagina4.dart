import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina1.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:audioplayers/audioplayers.dart';

class Pagina4Page extends StatefulWidget {
  const Pagina4Page({super.key});

  @override
  Pagina4PageState createState() =>
      Pagina4PageState(); // Aqui mantém a referência para a classe pública
}

// TORNANDO A CLASSE PÚBLICA REMOVENDO O UNDERLINE
class Pagina4PageState extends State<Pagina4Page> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  // Função para reproduzir o áudio
  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('audio/audiopag4.mp3'));
  }

  // Função para parar o áudio
  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }

  // Função para alternar entre tocar e pausar o áudio
  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause(); // Pausa o áudio
    } else {
      await _playAudio(); // Inicia o áudio
    }
    setState(() {
      _isPlaying = !_isPlaying; // Alterna o estado
    });
  }

  @override
  void initState() {
    super.initState();

    // Inicia o áudio logo após a página ser carregada
    _playAudio();

    // Aguarda 5 segundos antes de navegar para a próxima página
    Future.delayed(const Duration(seconds: 14), () {
      _stopAudio(); // Para o áudio antes de navegar

      // Navega para a próxima página
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Pagina1Page(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
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
                    return const ConfigDialog(); // Chama o diálogo de configurações
                  },
                );
              },
            ),
          ),
          Positioned(
            top: size.height * 0.15,
            right: size.width * 0.03,
            left: size.width * 0.03,
            child: SvgPicture.asset(
              'assets/images/pancreas.svg',
              height: size.height * 0.9,
            ),
          ),
          Positioned(
            top: size.height * 0.17,
            right: size.width * 0.07,
            child: SvgPicture.asset(
              'assets/images/balão-page4.svg',
              width: size.width * 1.0,
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
                    onPressed: _toggleAudio, // Ação do botão de som
                  ),
                  const SizedBox(
                    width:
                        60, // Espaço ocupado para manter o layout equilibrado
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
