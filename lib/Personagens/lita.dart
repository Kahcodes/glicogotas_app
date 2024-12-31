import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/Personagens/glicogotas.dart';
import 'package:glicogotas_app/Personagens/rei.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/main.dart'; // Importa o routeObserver
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonagemLitaPage extends StatefulWidget {
  const PersonagemLitaPage({super.key});

  @override
  PersonagemLitaPageState createState() => PersonagemLitaPageState();
}

class PersonagemLitaPageState extends State<PersonagemLitaPage>
    with RouteAware {
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
        'audio/audioPersonagens/lita.mp3', context); // Reproduz o áudio
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
    _audioManager.play('audio/audioPersonagens/lita.mp3',
        context); // Reinicia o áudio ao voltar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              // Fundo com as listras
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/fundo-lita.svg',
                  fit: BoxFit.cover,
                ),
              ),

              // Botão de voltar no topo esquerdo
              Positioned(
                top: 40.h,
                left: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(
                    Icons.home_rounded,
                    color: Color.fromARGB(255, 0, 132, 255),
                  ),
                  onPressed: () {
                    _audioManager
                        .stop(); // Para o áudio ao ir para a tela inicial
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TelaHome()),
                    );
                  },
                ),
              ),

              // Botão de configurações no topo direito
              Positioned(
                top: 40.h,
                right: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 0, 132, 255),
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

              // Nome do personagem (Lita) centralizado
              Positioned(
                top: 0.15.sh,
                left: 0,
                right: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Texto branco (borda)
                    Text(
                      'Lita',
                      style: GoogleFonts.chewy(
                        fontSize: 0.13.sw,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color = const Color(0xFFFFFEFF),
                      ),
                    ),
                    // Texto rosa
                    Text(
                      'Lita',
                      style: GoogleFonts.chewy(
                        fontSize: 0.13.sw,
                        color: const Color(0xFFF4719C),
                      ),
                    ),
                  ],
                ),
              ),

              // A bola do personagem no fundo
              Positioned(
                top: 0.28.sh,
                left: 0,
                right: 0,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/lita-person.svg',
                    height: 0.36.sh,
                  ),
                ),
              ),

              // Personagem sobreposta à bola
              Positioned(
                top: 0.26.sh,
                left: 0,
                right: 0,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/lita-heroina.svg',
                    height: 0.42.sh,
                  ),
                ),
              ),

              // Descrição do personagem
              Positioned(
                bottom: 0.20.sh,
                left: 20.w,
                right: 20.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Texto branco (borda)
                    Text(
                      'É uma super-heroína que enfrenta o DM1 em grandes aventuras!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        fontSize: 0.06.sw,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color = const Color(0xFFFFFEFF),
                      ),
                    ),
                    // Texto rosa
                    Text(
                      'É uma super-heroína que enfrenta o DM1 em grandes aventuras!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        fontSize: 0.06.sw,
                        color: const Color(0xFFF4719C),
                      ),
                    ),
                  ],
                ),
              ),

              // Botões de navegação
              Positioned(
                bottom: 0.08.sh, // Abaixo da descrição
                left: 20.w, // Alinha à esquerda
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: const Color(0xFF00D287),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    _audioManager.stop(); // Para o áudio ao navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonagensPage()),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0.08.sh, // Abaixo da descrição
                right: 20.w, // Alinha à direita
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: const Color(0xFF00D287),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    _audioManager.stop(); // Para o áudio ao navegar
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonagemReiPage()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
