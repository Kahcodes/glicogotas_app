import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina1.dart';
import 'package:glicogotas_app/Livro/pagina3.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:glicogotas_app/main.dart'; // Importa o routeObserver
import 'package:provider/provider.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pagina2Page extends StatefulWidget {
  const Pagina2Page({super.key});

  @override
  Pagina2PageState createState() => Pagina2PageState();
}

class Pagina2PageState extends State<Pagina2Page> with RouteAware {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Função para salvar o número da página
  Future<void> _saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_page', page);
  }

  // Função para reproduzir o áudio
  Future<void> _playAudio() async {
    await _audioPlayer.stop(); // Garante que o áudio anterior seja parado
    await _audioPlayer.play(AssetSource('audio/audiopag2.mp3'));
  }

  // Função para atualizar configurações de áudio
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
    _saveCurrentPage(2); // Salva o número da página atual
    _playAudio(); // Inicia o áudio ao carregar a página
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
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
    _updateAudioStream(context);

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
                _audioPlayer.stop(); // Para o áudio ao navegar
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
                _audioPlayer.stop(); // Para o áudio ao navegar
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
