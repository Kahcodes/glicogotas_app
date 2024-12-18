import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/lita.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonagensPage extends StatefulWidget {
  const PersonagensPage({super.key});

  @override
  PersonagensPageState createState() => PersonagensPageState();
}

class PersonagensPageState extends State<PersonagensPage> with RouteAware {
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
    _saveCurrentPage(2); // Salva o número da página atual
    _audioManager.play(
        'audio/audioPersonagens/bemvindos.mp3', context); // Reproduz o áudio
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
    _audioManager.play('audio/audioPersonagens/bemvindos.mp3',
        context); // Reinicia o áudio ao voltar
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // O fundo azul cobrindo toda a tela
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundo-azul.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Botão de configurações no topo direito
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.settings, color: Colors.white),
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

          // Título "Bem-Vindos" com contorno branco e sombra
          Positioned(
            top: size.height * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                children: [
                  // Contorno branco
                  Text(
                    'Bem-Vindos',
                    style: GoogleFonts.chewy(
                      fontSize: size.width * 0.13, // Fonte maior
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.25), // Sombra suave
                          offset: const Offset(3.0, 3.0), // Ajuste de sombra
                          blurRadius: 5.0,
                        ),
                      ],
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 8
                        ..color =
                            const Color(0xFFFFFEFF), // Cor do contorno (branca)
                    ),
                  ),
                  // Preenchimento rosa e sombra
                  Text(
                    'Bem-Vindos',
                    style: GoogleFonts.chewy(
                      color: const Color(
                          0xFFF4719C), // Cor do preenchimento (rosa)
                      fontSize: size.width * 0.13, // Fonte maior
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // A imagem central ajustada para ficar parcialmente fora da tela
          Positioned(
            top: size.height * 0.22, // Alinhamento vertical
            left: 0, // A imagem começará da borda esquerda
            right: 0, // A imagem terminará na borda direita
            child: SvgPicture.asset(
              'assets/images/tela-inicial-perso.svg', // Caminho da imagem
              width: size.width, // Largura da imagem igual à largura da tela
              fit: BoxFit.cover, // Ajuste da imagem sem distorcer
            ),
          ),

          // Texto "À Turminha do Glicogotas!" centralizado
          Positioned(
            bottom: size.height * 0.15,
            left: size.width * 0.15,
            right: size.width * 0.15,
            child: Transform.rotate(
              angle: -0.03,
              child: FittedBox(
                fit: BoxFit.scaleDown, // Reduz o texto para caber na área
                child: Stack(
                  children: [
                    // Contorno branco
                    Text(
                      'À Turminha do Glicogotas!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        fontSize: size.width * 0.16,
                        fontWeight: FontWeight.w400,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(3.0, 3.0),
                            blurRadius: 5.0,
                          ),
                        ],
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color = const Color(0xFFFFFEFF),
                      ),
                    ),
                    // Preenchimento rosa e sombra
                    Text(
                      'À Turminha do Glicogotas!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        color: const Color(0xFFF4719C),
                        fontSize: size.width * 0.16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Botão "Avançar"
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/btn-avancar-branco.svg',
                  width: 65,
                ),
                onPressed: () {
                  _audioManager.stop(); // Para o áudio ao navegar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonagemLitaPage()),
                  );
                },
              ),
            ),
          ),

          // Botão de home no canto superior esquerdo
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.home_rounded, color: Colors.white),
              onPressed: () {
                _audioManager.stop(); // Para o áudio ao voltar ao início
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaHome()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
