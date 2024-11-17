import 'dart:async';
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

    // Inicia o áudio logo após a página ser carregada
    _playAudio();

    // Aguarda 5 segundos antes de navegar para a próxima página
    Future.delayed(const Duration(seconds: 5), () {
      // Para o áudio quando a página mudar
      _stopAudio();

      // Navega para a próxima página
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Pagina3Page(),
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
            top: size.height * 0.30,
            right: size.width * 0.15,
            child: SvgPicture.asset(
              'assets/images/lita-falando.svg',
              height: size.height * 0.6,
            ),
          ),
          Positioned(
            top: size.height * 0.2,
            left: size.width * 0.02,
            right: size.width * 0.03,
            child: SvgPicture.asset(
              'assets/images/balão-page2.svg',
              width: size.width * 0.80,
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
                            builder: (context) => const TelaHome()),
                      );
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-som-laranja.svg',
                      width: 60,
                    ),
                    onPressed: () {
                      // Ação do botão som
                    },
                  ),
                  const SizedBox(
                    width: 60,
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
