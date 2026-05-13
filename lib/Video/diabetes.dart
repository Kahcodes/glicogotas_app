// ignore_for_file: sized_box_for_whitespace

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

  void _navigateBack() {
    _controller.pause();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      body: Stack(
        children: [
          // Fundo
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundopaglivro.svg',
              fit: BoxFit.fill,
            ),
          ),

          // Botão voltar
          Positioned(
            top: 40.h,
            left: 16.w,
            child: IconButton(
              iconSize: 30.sp, // mesmo tamanho que a outra página
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Color.fromARGB(255, 255, 50, 132),
              ),
              onPressed: _navigateBack,
            ),
          ),

          // Botão configurações
          Positioned(
            top: 40.h,
            right: 16.w,
            child: IconButton(
              iconSize: 30.sp, // mesmo tamanho que a outra página
              icon: const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 255, 50, 132),
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

          // Conteúdo principal
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 80.h), // espaço do topo

                // Título
                Text(
                  'Lita - Diabetes Tipo 1',
                  style: GoogleFonts.chewy(
                    color: Colors.orange,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16.h),

                // Dentro do Column principal, substituindo o bloco do vídeo:

// Container do vídeo com barra de progresso interativa
                Flexible(
                  child: Container(
                    width: 320.w,
                    height: 200.h,
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(14.r),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                VideoPlayer(_controller),
                                // Barra de progresso interativa com tamanho aumentado
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 8.h, // Aumenta a altura da barra
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: VideoProgressIndicator(
                                      _controller,
                                      allowScrubbing: true,
                                      colors: VideoProgressColors(
                                        playedColor: Colors.orange,
                                        bufferedColor:
                                            Colors.white.withValues(alpha: 0.9),
                                        backgroundColor:
                                            Colors.white.withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Botão Play/Pause grande
                SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: FloatingActionButton(
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
                      size: 30.sp, // mesmo tamanho da outra página
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
