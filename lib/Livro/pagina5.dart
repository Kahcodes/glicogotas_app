import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina6.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/main.dart';
import 'package:glicogotas_app/Livro/pagina4.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Página 5 como StatefulWidget
class Pagina5Page extends StatefulWidget {
  const Pagina5Page({super.key});

  @override
  Pagina5PageState createState() => Pagina5PageState();
}

class Pagina5PageState extends State<Pagina5Page> with RouteAware {
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
    _saveCurrentPage(5); // Salva o número da página atual
    _audioManager.play('audio/audiopag1.mp3', context); // Reproduz o áudio
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
        'audio/audiopag5.mp3', context); // Reinicia o áudio ao voltar
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

          // Imagem do pâncreas
          Positioned(
            top: size.height * 0.33,
            left: size.width * 0.05,
            child: SvgPicture.asset(
              'assets/images/pancreas.svg',
              width: size.width * 0.99,
            ),
          ),

          // Balão com texto
          Positioned(
            top: size.height * 0.16,
            left: -size.width * 0.04,
            child: SvgPicture.asset(
              'assets/images/balão-page5.svg',
              width: size.width * 0.94,
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
                _audioManager.stop();
                Navigator.pushReplacement(
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
                    return const ConfigDialog();
                  },
                );
              },
            ),
          ),

          // Botão Voltar
          Positioned(
            bottom: size.height * 0.08,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 48,
                color: Color(0xFF265F95),
              ),
              onPressed: () {
                _audioManager.stop();
                _saveCurrentPage(4);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina4Page()),
                );
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
                _saveCurrentPage(6); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina6Page()),
                ); // Navega para a próxima página
              },
            ),
          ),
        ],
      ),
    );
  }
}
