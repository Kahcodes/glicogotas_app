import 'package:flutter/material.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoDiabetesPage extends StatefulWidget {
  const VideoDiabetesPage({super.key});

  @override
  State<VideoDiabetesPage> createState() => _VideoDiabetesPageState();
}

class _VideoDiabetesPageState extends State<VideoDiabetesPage>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = VideoPlayerController.asset('assets/videos/Lita_DM1.mp4')
      ..initialize().then((_) {
        setState(() => _isLoading = false);
        _controller.play();
      });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _controller.pause();
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

          bool isTablet = constraints.maxWidth > 600;

          return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {
                _controller.pause();
              }
            },
            child: Stack(
              children: [
                /// Fundo SVG
                Positioned.fill(
                  child: SvgPicture.asset(
                    'assets/images/fundopaglivro.svg',
                    fit: BoxFit.cover,
                  ),
                ),

                /// ---- MENU SUPERIOR ---- 
                Positioned(
                  top: 40.h,
                  left: 16.w,
                  right: 16.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Ícone Home
                      IconButton(
                        iconSize: 30.sp,
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Color(0xFF37ABDC),
                        ),
                        onPressed: () {
                          _controller.pause();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TelaHome(),
                            ),
                          );
                        },
                      ),

                      // Título (mesmo estilo)
                      Text(
                        'Lita - Diabetes Tipo I',
                        style: GoogleFonts.chewy(
                          color: Colors.black,
                          fontSize: 24.sp,
                        ),
                      ),

                      // Ícone Configurações
                      IconButton(
                        iconSize: 30.sp,
                        icon: const Icon(
                          Icons.settings,
                          color: Color(0xFF37ABDC),
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
                    ],
                  ),
                ),

                /// ---- CONTEÚDO ----
                Padding(
                  padding: EdgeInsets.only(top: 90.h),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Vídeo com borda laranja
                        _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.orange,
                                strokeWidth: isTablet ? 4.0 : 2.0,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.orange, width: 4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: SizedBox(
                                    width: constraints.maxWidth * 0.9,
                                    child: AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          VideoPlayer(_controller),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: VideoProgressIndicator(
                                              _controller,
                                              allowScrubbing: true,
                                              colors:
                                                  const VideoProgressColors(
                                                playedColor: Colors.orange,
                                                backgroundColor:
                                                    Colors.white54,
                                                bufferedColor:
                                                    Colors.white24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                        SizedBox(height: 20.h),

                        // Botão Play/Pause
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          backgroundColor: Colors.orange,
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: isTablet ? 32.sp : 28.sp,
                          ),
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


