import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/Livro/capa.dart';
import 'package:glicogotas_app/Livro/pagina2.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/main.dart'; // Importa o routeObserver
import 'package:glicogotas_app/sqlite.dart';

class Pagina1Page extends StatefulWidget {
  const Pagina1Page({super.key});

  @override
  State<Pagina1Page> createState() => _Pagina1PageState();
}

class _Pagina1PageState extends State<Pagina1Page> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    PageDatabase.instance.saveCurrentPage(2); // Salva o número da página atual
    _audioManager.play('audio/panc-pagina1.mp3', context); // Reproduz o áudio
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioManager.stop(); // Para o áudio ao sair da página
    _audioManager.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioManager.stop(); // Para o áudio ao ir para a próxima página
  }

  @override
  void didPopNext() {
    _audioManager.play(
        'audio/audiopag2.mp3', context); // Reinicia o áudio ao voltar
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
            top: size.height * 0.14,
            left: size.width * 0.02,
            right: size.width * 0.02,
            child: SvgPicture.asset(
              'assets/images/balão-duplo.svg',
              width: size.width * 0.8,
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
                _audioManager.stop(); // Para o áudio ao voltar à tela inicial
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

          // Botão de navegação anterior
          Positioned(
            bottom: size.height * 0.08,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xFF265F95),
                size: 48,
              ),
              onPressed: () {
                _audioManager.stop();
                PageDatabase.instance.saveCurrentPage(1);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CapaPage()),
                );
              },
            ),
          ),

          // Botão de navegação próxima
          Positioned(
            bottom: size.height * 0.08,
            right: 20,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF265F95),
                size: 48,
              ),
              onPressed: () {
                _audioManager.stop();
                PageDatabase.instance.saveCurrentPage(3);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina2Page()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
