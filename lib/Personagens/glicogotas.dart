import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/betinho.dart';
import 'package:glicogotas_app/Personagens/bobo.dart';
import 'package:glicogotas_app/Personagens/fe.dart';
import 'package:glicogotas_app/Personagens/insulins.dart';
import 'package:glicogotas_app/Personagens/lita.dart';
import 'package:glicogotas_app/Personagens/pumps.dart';
import 'package:glicogotas_app/Personagens/rei.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/main.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonagensPage extends StatefulWidget {
  const PersonagensPage({super.key});

  @override
  PersonagensPageState createState() => PersonagensPageState();
}

class PersonagensPageState extends State<PersonagensPage> with RouteAware {
  final AudioManager _audioManager = AudioManager();
  final PageController _pageController =
      PageController(); // Controlador do PageView
  int _currentPage = 0;

  final List<Widget> _pages = const [
    PersonagensContent(),
    PersonagemLitaPage(),
    PersonagemReiPage(),
    PersonagemBoboPage(),
    PersonagemFePage(),
    PersonagemInsulinsPage(),
    PersonagemPumpsPage(),
    PersonagemBetinhoPage(),
  ];

  // Função para reproduzir o áudio
  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      backgroundColor: const Color(0xFF265F95),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double scale = 1.0;
                    double opacity = 1.0;

                    if (_pageController.position.haveDimensions) {
                      double page = _pageController.page ?? 0.0;
                      scale = (1 - (index - page).abs()).clamp(0.85, 1.0);
                      opacity = (1 - (index - page).abs()).clamp(0.5, 1.0);
                    }

                    return Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity,
                        child: _pages[index],
                      ),
                    );
                  },
                );
              },
            ),
            // Indicador de navegação (Dots)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.yellow
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            // Botão de avançar ou voltar
            if (_currentPage > 0)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Color.fromARGB(0, 255, 255, 255)),
                  onPressed: () {
                    _audioManager.stop();
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            if (_currentPage < _pages.length - 1)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Color.fromARGB(0, 255, 255, 255)),
                  onPressed: () {
                    _audioManager.stop();
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PersonagensContent extends StatelessWidget {
  const PersonagensContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final audioManager = AudioManager();

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
                  audioManager.stop(); // Para o áudio ao navegar
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
                audioManager.stop(); // Para o áudio ao voltar ao início
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
