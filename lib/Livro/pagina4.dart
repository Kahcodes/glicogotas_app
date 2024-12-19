import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina3.dart'; // Importar a página anterior
import 'package:glicogotas_app/Livro/pagina5.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/main.dart'; // Certifique-se de que o caminho esteja correto
import 'package:shared_preferences/shared_preferences.dart';

class Pagina4Page extends StatefulWidget {
  const Pagina4Page({super.key});

  @override
  Pagina4PageState createState() => Pagina4PageState();
}

class Pagina4PageState extends State<Pagina4Page> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  // Função para reproduzir o áudio
  Future<void> _saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_page', page);
  }

  // Função para reproduzir o áudio
  @override
  void initState() {
    super.initState();
    _saveCurrentPage(4); // Salva o número da página atual
    _audioManager.play('audio/panc-pagina4.mp3', context); // Reproduz o áudio
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
        'audio/panc-pagina3.mp3', context); // Reinicia o áudio ao voltar
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
                _audioManager.stop(); // Para o áudio ao voltar à tela inicial
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
                _audioManager.stop();
                _saveCurrentPage(3); // Para o áudio ao navegar
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
                _audioManager.stop();
                _saveCurrentPage(5); // Para o áudio ao navegar
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
