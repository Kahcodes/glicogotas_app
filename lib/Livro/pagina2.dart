import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina1.dart';
import 'package:glicogotas_app/Livro/pagina3.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/main.dart'; // Importa o routeObserver
import 'package:shared_preferences/shared_preferences.dart';

class Pagina2Page extends StatefulWidget {
  const Pagina2Page({super.key});

  @override
  Pagina2PageState createState() => Pagina2PageState();
}

class Pagina2PageState extends State<Pagina2Page> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  // Função para salvar o número da página
  Future<void> _saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_page', page);
  }

  // Função para reproduzir o áudio
  @override
  void initState() {
    super.initState();
    _saveCurrentPage(2); // Salva o número da página atual
    _audioManager.play('audio/audiopag2.mp3', context); // Reproduz o áudio
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

          // Lita falando
          Positioned(
            top: size.height * 0.30,
            right: size.width * 0.15,
            child: SvgPicture.asset(
              'assets/images/lita.svg',
              height: size.height * 0.6,
            ),
          ),

          // Balão de fala
          Positioned(
            top: size.height * 0.15,
            left: size.width * 0.03,
            right: size.width * 0.03,
            child: SvgPicture.asset(
              'assets/images/balão-page2.svg',
              width: size.width * 0.99,
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
                _audioManager.stop(); // Para o áudio ao voltar à tela inicial
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
                _saveCurrentPage(1); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina1Page()),
                ); // Volta para a página anterior
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
                _saveCurrentPage(3); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina3Page()),
                ); // Vai para a próxima página
              },
            ),
          ),
        ],
      ),
    );
  }
}
