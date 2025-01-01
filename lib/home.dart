import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/glicogotas.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/iniciar.dart';
import 'package:glicogotas_app/main.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_app/Tirinhas/tirinha.cards.dart';
import 'package:glicogotas_app/Livro/cards.dart';
import 'package:glicogotas_app/jogos.dart';
import 'package:provider/provider.dart';
import 'configuracoes.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  TelaHomeState createState() => TelaHomeState();
}

class TelaHomeState extends State<TelaHome> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    final configProvider = Provider.of<ConfiguracoesRepository>(
      context,
      listen: false,
    );

    // Escuta as mudanças na configuração de música
    configProvider.addListener(() {
      if (configProvider.musicOn) {
        _audioManager.play('audio/musica.mp3', context);
      } else {
        _audioManager.stop();
      }
    });

    // Inicia a música se a configuração estiver habilitada
    if (configProvider.musicOn && !_audioManager.isPlaying) {
      _audioManager.setVolume(configProvider.volume);
      _audioManager.play('audio/musica.mp3', context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioManager.stop();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioManager.stop();
  }

  @override
  void didPopNext() {
    _audioManager.play('audio/musica.mp3', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                // Fundo com decoração em SVG
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SvgPicture.asset(
                      'assets/images/decoracao.svg',
                    ),
                  ),
                ),

                // Ícone de voltar
                Positioned(
                  top: 40.h,
                  left: 16.w,
                  child: IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Color(0xFF265F95)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaInicial(),
                        ),
                      );
                    },
                  ),
                ),

                // Ícone de configurações
                Positioned(
                  top: 40.h,
                  right: 16.w,
                  child: IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(Icons.settings, color: Color(0xFF265F95)),
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

                // Conteúdo principal
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Texto e imagem
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Ícone principal
                            SizedBox(
                              width: 120.w,
                              height: 200.h,
                              child: ClipRect(
                                child: Image.asset(
                                  'assets/images/talita_icon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Como vamos',
                                  style: GoogleFonts.sansitaSwashed(
                                    color: const Color(0xFF37ABDC),
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'aprender',
                                        style: GoogleFonts.sansitaSwashed(
                                          color: const Color(0xFFF4719C),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' hoje?',
                                        style: GoogleFonts.sansitaSwashed(
                                          color: const Color(0xFF37ABDC),
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40.h),

                      // Botão PERSONAGENS
                      ElevatedButton(
                        onPressed: () {
                          _audioManager.stop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PersonagensPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D287),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                        ),
                        child: SizedBox(
                          width: 149.w,
                          height: 26.h,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  "assets/images/person.svg",
                                  fit: BoxFit.cover,
                                  height: 23.h,
                                  width: 23.w,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'PERSONAGENS',
                                  style: GoogleFonts.podkova(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Botão LIVRO
                      ElevatedButton(
                        onPressed: () {
                          _audioManager.stop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LivroCardsPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                        ),
                        child: SizedBox(
                          width: 149.w,
                          height: 26.h,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  "assets/images/livro.svg",
                                  fit: BoxFit.cover,
                                  height: 24.h,
                                  width: 24.w,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'LIVRO',
                                  style: GoogleFonts.podkova(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Botão TIRINHAS
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TirinhaCardsPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFCB44E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                        ),
                        child: SizedBox(
                          width: 149.w,
                          height: 26.h,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  "assets/images/historia.svg",
                                  fit: BoxFit.cover,
                                  height: 24.h,
                                  width: 24.w,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'TIRINHAS',
                                  style: GoogleFonts.podkova(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Botão JOGOS
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const JogosPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                        ),
                        child: SizedBox(
                          width: 149.w,
                          height: 26.h,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  "assets/images/jogos.svg",
                                  fit: BoxFit.cover,
                                  height: 24.h,
                                  width: 24.w,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'JOGOS',
                                  style: GoogleFonts.podkova(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
