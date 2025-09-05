import 'package:flutter/material.dart';
import 'package:glicogotas_app/configuracoes.dart';
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
    _controller.pause(); // Pausa o vídeo
    _controller.dispose(); // Dispose do controller
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Pausa o vídeo quando o app vai para background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _controller.pause();
    }
  }

  void _navigateBack() {
    _controller.pause(); // Pausa antes de sair
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: constraints.maxWidth > 600
                ? const Size(768, 1024)
                : const Size(360, 690),
            minTextAdapt: true,
          );

          bool isTablet = constraints.maxWidth > 600;

          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: () async {
              _controller.pause(); // Pausa quando usar botão voltar do sistema
              return true;
            },
            child: Stack(
              children: [
                // Fundo SVG
                Positioned.fill(
                  child: SvgPicture.asset(
                    'assets/images/fundopaglivro.svg',
                    fit: BoxFit.cover,
                  ),
                ),

                SafeArea(
                  child: Column(
                    children: [
                      // AppBar customizado

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: Row(
                          children: [
                            IconButton(
                              iconSize: isTablet ? 35.sp : 30.sp,
                              icon: const Icon(Icons.home_rounded,
                                  color: Colors.pinkAccent),
                              onPressed:
                                  _navigateBack, // Usa a função que pausa
                            ),
                            const Spacer(),
                            IconButton(
                              iconSize: isTablet ? 35.sp : 30.sp,
                              icon: const Icon(Icons.settings,
                                  color: Colors.pinkAccent),
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

                      // Centraliza título, vídeo e botão
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Título bem próximo do vídeo
                              Text(
                                'Lita - Diabetes Tipo 1',
                                style: GoogleFonts.chewy(
                                  color: Colors.orange,
                                  fontSize: isTablet ? 28.sp : 24.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 8.h),

                              // Vídeo
                              _isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.orange,
                                      strokeWidth: isTablet ? 4.0 : 2.0,
                                    )
                                  : AspectRatio(
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
                                            child: SizedBox(
                                              height: isTablet ? 8.h : 6.h,
                                              child: VideoProgressIndicator(
                                                _controller,
                                                allowScrubbing: true,
                                                colors:
                                                    const VideoProgressColors(
                                                  playedColor: Colors.orange,
                                                  backgroundColor:
                                                      Colors.white54,
                                                  bufferedColor: Colors.white24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                              SizedBox(height: 12.h),

                              // Botão logo abaixo do vídeo
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}