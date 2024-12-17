import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina6.dart';
import 'package:glicogotas_app/main.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Página 5 como StatefulWidget
class Pagina7Page extends StatefulWidget {
  const Pagina7Page({super.key});

  @override
  Pagina7PageState createState() => Pagina7PageState();
}

class Pagina7PageState extends State<Pagina7Page> with RouteAware {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Função para reproduzir o áudio
  Future<void> _playAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('audio/audiopag4.mp3'));
  }

  // Pausar ou retomar áudio baseado no Provider
  void _handleAudioSettings(BuildContext context) {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: false);

    if (configuracoesProvider.soundOn) {
      _audioPlayer.resume();
    } else {
      _audioPlayer.pause();
    }
  }

  Future<void> _saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_page', page);
  }

  @override
  void initState() {
    super.initState();
    _playAudio(); // Inicia o áudio ao carregar a página
    _saveCurrentPage(7); // Salva que o usuário está na Página 1
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioPlayer.pause(); // Pausa o áudio ao ir para outra página
  }

  @override
  void didPopNext() {
    _playAudio(); // Retoma o áudio ao voltar para esta página
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleAudioSettings(context);
    });

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
              'assets/images/balão-page7.svg',
              width: size.width * 0.99,
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
                _audioPlayer.stop();
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
                _audioPlayer.stop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Pagina6Page()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
