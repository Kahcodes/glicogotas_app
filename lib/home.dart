import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/glicogotas.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/iniciar.dart';
import 'package:glicogotas_app/main.dart';
import 'package:glicogotas_app/MitosOuVerdades/cards_mitos.dart';
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

    configProvider.addListener(() {
      if (configProvider.musicOn) {
        _audioManager.play('audio/musica.mp3', context);
      } else {
        _audioManager.stop();
      }
    });

    if (configProvider.musicOn && !_audioManager.isPlaying) {
      _audioManager.setVolume(configProvider.volume);
      _audioManager.play('audio/musica.mp3', context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
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

  Widget buildButton({
    required VoidCallback onPressed,
    required Color color,
    required String label,
    required Widget icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      ),
      child: SizedBox(
        width: 160.w,
        height: 32.h,
        child: Row(
          children: [
            icon,
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.podkova(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SvgPicture.asset('assets/images/decoracao.svg'),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 16.w,
                  child: IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF265F95)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TelaInicial()),
                      );
                    },
                  ),
                ),
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
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' hoje?',
                                        style: GoogleFonts.sansitaSwashed(
                                          color: const Color(0xFF37ABDC),
                                          fontSize: 24.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        buildButton(
                          onPressed: () {
                            _audioManager.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PersonagensPage()),
                            );
                          },
                          color: const Color(0xFF00D287),
                          label: 'PERSONAGENS',
                          icon: SvgPicture.asset(
                            "assets/images/person.svg",
                            height: 20.h,
                            width: 20.w,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        buildButton(
                          onPressed: () {
                            _audioManager.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LivroCardsPage()),
                            );
                          },
                          color: Colors.blue,
                          label: 'LIVRO',
                          icon: SvgPicture.asset(
                            "assets/images/livro.svg",
                            height: 20.h,
                            width: 20.w,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        buildButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const TirinhaCardsPage()),
                            );
                          },
                          color: const Color(0xFFFCB44E),
                          label: 'TIRINHAS',
                          icon: SvgPicture.asset(
                            "assets/images/historia.svg",
                            height: 20.h,
                            width: 20.w,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        buildButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const JogosPage()),
                            );
                          },
                          color: Colors.pinkAccent,
                          label: 'JOGOS',
                          icon: SvgPicture.asset(
                            "assets/images/jogos.svg",
                            height: 20.h,
                            width: 20.w,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        buildButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MitosOuVerdadesPage()),
                            );
                          },
                          color: const Color(0xFF9C6ADE),
                          label: 'MITO OU VERDADE',
                          icon: Icon(Icons.question_answer, color: Colors.white, size: 20.sp),
                        ),
                      ],
                    ),
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
