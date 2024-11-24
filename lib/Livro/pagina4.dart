import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:glicogotas_app/main.dart'; // Certifique-se de que o caminho esteja correto
import 'pagina5.dart';

class Pagina4Page extends StatefulWidget {
  const Pagina4Page({super.key});

  @override
  Pagina4PageState createState() => Pagina4PageState();
}

class Pagina4PageState extends State<Pagina4Page> with RouteAware {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Função para reproduzir o áudio
  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('audio/audiopag4.mp3'));
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this); // Desinscreve-se ao sair
    _stopAudio(); // Para o áudio ao sair
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _stopAudio(); // Para o áudio ao ir para outra página
  }

  @override
  void didPopNext() {
    _playAudio(); // Reinicia o áudio ao voltar para esta página
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

          // Elementos visuais principais
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

          // Botões invisíveis de navegação (lado esquerdo e direito)
          // Botão invisível para voltar (lado esquerdo)
          Positioned(
            top: 80, // Ajuste para ficar abaixo dos botões de navegação
            left: 0,
            child: GestureDetector(
              onTap: () {
                _stopAudio(); // Para o áudio ao navegar
                Navigator.pop(context); // Voltar para a página anterior
              },
              child: Container(
                width: size.width * 0.45,
                height: size.height - 80, // Aumenta a área de interação
                color: Colors.transparent, // Invisível mas funcional
              ),
            ),
          ),

          // Botão invisível para avançar (lado direito)
          Positioned(
            top: 80, // Ajuste para ficar abaixo dos botões de navegação
            right: 0,
            child: GestureDetector(
              onTap: () {
                _stopAudio(); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina5Page()),
                );
              },
              child: Container(
                width: size.width * 0.45,
                height: size.height - 80, // Aumenta a área de interação
                color: Colors.transparent, // Invisível mas funcional
              ),
            ),
          ),
        ],
      ),
    );
  }
}
