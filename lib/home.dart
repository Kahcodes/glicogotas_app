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

class TelaHomeState extends State<TelaHome> with RouteAware, WidgetsBindingObserver {
  final AudioManager _audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _playBackgroundMusic();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    _audioManager.stop();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  void _playBackgroundMusic() async {
    final configProvider = Provider.of<ConfiguracoesRepository>(context, listen: false);

    configProvider.addListener(() {
      if (configProvider.musicOn) {
        _audioManager.setVolume(configProvider.volume);
        _audioManager.play('audio/musica.mp3', context);
      } else {
        _audioManager.stop();
      }
    });

    if (configProvider.musicOn) {
      _audioManager.setVolume(configProvider.volume);
      _audioManager.play('audio/musica.mp3', context);
    }
  }

  @override
  void didPushNext() {
    _audioManager.stop();
  }

  @override
  void didPopNext() {
    final configProvider = Provider.of<ConfiguracoesRepository>(context, listen: false);
    if (configProvider.musicOn) {
      _audioManager.play('audio/musica.mp3', context);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final configProvider = Provider.of<ConfiguracoesRepository>(context, listen: false);
    if (state == AppLifecycleState.paused) {
      _audioManager.stop();
    } else if (state == AppLifecycleState.resumed && configProvider.musicOn) {
      _audioManager.play('audio/musica.mp3', context);
    }
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

          const int columns = 2;
          const int itemCount = 6;

          final double gridHPad = 22.w;
          final double crossSpacing = 16.w;
          final double mainSpacing = 18.h;

          final double usableWidth = constraints.maxWidth - (gridHPad * 2) - (crossSpacing * (columns - 1));
          double itemSide = usableWidth / columns;

          final double maxSide = constraints.maxHeight * 0.16;
          final double minSide = 92.w;
          if (itemSide > maxSide) itemSide = maxSide;
          if (itemSide < minSide) itemSide = minSide;

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

                // Botão de voltar
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

                // Botão de configurações
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

                // Cabeçalho fixo (Talita + texto)
                Positioned(
                  top: 90.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 85.w,
                          height: 110.h,
                          child: Image.asset(
                            'assets/images/talita_icon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Como vamos',
                              style: GoogleFonts.sansitaSwashed(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF37ABDC),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.sansitaSwashed(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: const [
                                  TextSpan(
                                    text: 'aprender ',
                                    style: TextStyle(color: Color(0xFFF4719C)),
                                  ),
                                  TextSpan(
                                    text: 'hoje?',
                                    style: TextStyle(color: Color(0xFF37ABDC)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Botões
                Positioned(
                  top: 230.h,
                  left: 0,
                  right: 0,
                  bottom: 8.h,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: gridHPad),
                    itemCount: itemCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: crossSpacing,
                      mainAxisSpacing: mainSpacing,
                      mainAxisExtent: itemSide,
                    ),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return CardButton(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PersonagensPage(),
                                ),
                              );
                            },
                            color: const Color(0xFF00D287),
                            label: "Personagens",
                            icon: Icon(Icons.people, size: 22.sp, color: Colors.white),
                          );
                        case 1:
                          return CardButton(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TirinhaCardsPage(),
                                ),
                              );
                            },
                            color: Colors.orange,
                            label: "Vídeo",
                            icon: Icon(Icons.video_collection, size: 22.sp, color: Colors.white),
                          );
                        case 2:
                          return CardButton(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LivroCardsPage(),
                                ),
                              );
                            },
                            color: Colors.blue,
                            label: "Livro",
                            icon: Icon(Icons.menu_book, size: 22.sp, color: Colors.white),
                          );
                        case 3:
                          return CardButton(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MitosOuVerdadesPage(),
                                ),
                              );
                            },
                            color: const Color(0xFF9C6ADE),
                            label: "Mitos ou Verdades",
                            icon: Icon(Icons.question_answer, size: 22.sp, color: Colors.white),
                          );
                        case 4:
                          return CardButton(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TirinhaCardsPage(),
                                ),
                              );
                            },
                            color: Colors.pinkAccent,
                            label: "Tirinhas",
                            icon: Icon(Icons.style, size: 22.sp, color: Colors.white),
                          );
                        case 5:
                        default:
                          return CardButton(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const JogosPage(),
                                ),
                              );
                            },
                            color: Colors.teal,
                            label: "Jogos",
                            icon: Icon(Icons.sports_esports, size: 22.sp, color: Colors.white),
                          );
                      }
                    },
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

///
/// Botão com efeito de "afundar" ao pressionar
///
class CardButton extends StatefulWidget {
  final VoidCallback onTap;
  final Color color;
  final String label;
  final Widget icon;

  const CardButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.label,
    required this.icon,
  });

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20.r),
          border: Border(
            bottom: BorderSide(
              color: _isPressed
                  ? Colors.transparent
                  : Colors.grey.withValues(alpha: 0.4),
              width: 3,
            ),
          ),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        margin: EdgeInsets.all(6.w),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            SizedBox(height: 6.h),
            Text(
              widget.label.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.podkova(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}