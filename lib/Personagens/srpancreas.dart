import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/main.dart';
import 'ordem_personagens.dart';
import 'package:glicogotas_app/navegacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonagemSrPancreasPage extends StatefulWidget {
  const PersonagemSrPancreasPage({super.key});

  @override
  PersonagemSrPancreasPageState createState() => PersonagemSrPancreasPageState();
}

class PersonagemSrPancreasPageState extends State<PersonagemSrPancreasPage>
    with RouteAware {
  final AudioManager _audioManager = AudioManager();
  static const _narracao = 'audio/audioPersonagens/senhorpancreas.mp3';

  @override
  void initState() {
    super.initState();
    _audioManager.play(_narracao, context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) routeObserver.subscribe(this, route);
  }

  @override
  void didPushNext() {
    _audioManager.stop();
  }

  @override
  void didPopNext() {
    _audioManager.play(_narracao, context);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioManager.stop();
    _audioManager.dispose();
    super.dispose();
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
                  'assets/images/fundo-srpancreas.svg',
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
                    _audioManager.stop();
                    voltarAoMenu(context, '/TelaHome', const TelaHome());
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

              // Nome do Senhor Pâncreas
              Positioned(
                top: 0.15.sh,
                left: 0,
                right: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Texto branco (borda)
                    Text(
                      'Senhor Pâncreas',
                      style: GoogleFonts.chewy(
                        fontSize: 0.10.sw,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color = const Color(0xFFFFFEFF),
                      ),
                    ),
                    // Texto rosa
                    Text(
                      'Senhor Pâncreas',
                      style: GoogleFonts.chewy(
                        fontSize: 0.10.sw,
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
                    'assets/images/eclipse-srpancreas.svg',
                    height: 0.36.sh,
                  ),
                ),
              ),

              // Personagem sobreposto à bola
              Positioned(
                top: 0.33.sh,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/srpancreas-person.png',
                    height: 0.26.sh,
                    width: 0.76.sw,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Descrição do personagem
              Positioned(
                bottom: 0.18.sh,
                left: 20.w,
                right: 20.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Texto branco (borda)
                    Text(
                      'O Senhor Pâncreas conhece uma chavinha muito importante, chamada insulina. Ela ajuda o açúcar a entrar onde é necessário.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        fontSize: 0.055.sw,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color = const Color(0xFFFFFEFF),
                      ),
                    ),
                    // Texto rosa
                    Text(
                      'O Senhor Pâncreas conhece uma chavinha muito importante, chamada insulina. Ela ajuda o açúcar a entrar onde é necessário.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        fontSize: 0.055.sw,
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
                    color: const Color(0xFFEC9512),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    _audioManager.stop();
                    navegarPersonagem(context, PersonagemSrPancreasPage, -1);
                  },
                ),
              ),
              Positioned(
                bottom: 0.08.sh, // Abaixo da descrição
                right: 20.w, // Alinha à direita
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: const Color(0xFFEC9512),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    _audioManager.stop();
                    navegarPersonagem(context, PersonagemSrPancreasPage, 1);
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
