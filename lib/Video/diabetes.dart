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
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Configuração responsiva do ScreenUtil
          final double screenWidth = constraints.maxWidth;
          final double screenHeight = constraints.maxHeight;

          // Detecta tipo de dispositivo
          bool isPhone = screenWidth < 600;
          bool isTablet = screenWidth >= 600 && screenWidth < 1200;

          ScreenUtil.init(
            context,
            designSize: isPhone
                ? const Size(360, 690) // Phone
                : isTablet
                    ? const Size(768, 1024) // Tablet
                    : const Size(1200, 800), // Desktop
            minTextAdapt: true,
          );

          // Tamanhos responsivos
          double titleSize = isPhone
              ? 24.sp
              : isTablet
                  ? 28.sp
                  : 32.sp;
          double fabSize = isPhone
              ? 28.sp
              : isTablet
                  ? 32.sp
                  : 36.sp;
          double progressHeight = isPhone
              ? 6.h
              : isTablet
                  ? 8.h
                  : 10.h;

          double titleVideoSpacing = isPhone
              ? 8.h
              : isTablet
                  ? 12.h
                  : 16.h;
          double videoButtonSpacing = isPhone
              ? 12.h
              : isTablet
                  ? 16.h
                  : 20.h;

          // Constraint para o vídeo
          double maxVideoWidth = isPhone
              ? screenWidth * 0.95
              : isTablet
                  ? screenWidth * 0.8
                  : screenWidth * 0.6;

          double maxVideoHeight = isPhone
              ? screenHeight * 0.6
              : isTablet
                  ? screenHeight * 0.65
                  : screenHeight * 0.7;

          return PopScope(
            // ignore: deprecated_member_use
            onPopInvoked: (didPop) {
              if (didPop) _controller.pause();
            },
            child: Stack(
              children: [
                // Fundo SVG responsivo
                Positioned.fill(
                  child: SvgPicture.asset(
                    'assets/images/fundopaglivro.svg',
                    fit: BoxFit.fill,
                  ),
                ),

                Column(
                  children: [
                    // AppBar personalizada
                    Padding(
                      padding: EdgeInsets.only(
                        top: 55.h,
                        left: 26.w,
                        right: 26.w,
                        bottom: 26.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Botão de voltar padronizado
                          IconButton(
                            iconSize: 30.sp,
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Color.fromARGB(255, 255, 50, 132),
                            ),
                            onPressed: _navigateBack,
                          ),

                          // Botão de configurações padronizado
                          IconButton(
                            iconSize: 30.sp,
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
                        ],
                      ),
                    ),

                    // Conteúdo principal responsivo
                    Expanded(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: maxVideoWidth,
                            maxHeight: screenHeight * 0.8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Título responsivo
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isPhone ? 16.w : 24.w,
                                ),
                                child: Text(
                                  'Lita - Diabetes Tipo 1',
                                  style: GoogleFonts.chewy(
                                    color: Colors.orange,
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: isPhone ? 2 : 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(height: titleVideoSpacing),

                              // Container do vídeo responsivo
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: maxVideoWidth,
                                    maxHeight: maxVideoHeight,
                                  ),
                                  child: _isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.orange,
                                            strokeWidth: isPhone ? 3.0 : 4.0,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            isPhone
                                                ? 12.r
                                                : isTablet
                                                    ? 16.r
                                                    : 20.r,
                                          ),
                                          child: AspectRatio(
                                            aspectRatio:
                                                _controller.value.aspectRatio,
                                            child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                VideoPlayer(_controller),
                                                // Barra de progresso responsiva
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    height: progressHeight,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.black
                                                              // ignore: deprecated_member_use
                                                              .withOpacity(0.3),
                                                        ],
                                                      ),
                                                    ),
                                                    child:
                                                        VideoProgressIndicator(
                                                      _controller,
                                                      allowScrubbing: true,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: isPhone
                                                            ? 8.w
                                                            : 12.w,
                                                      ),
                                                      colors:
                                                          VideoProgressColors(
                                                        playedColor:
                                                            Colors.orange,
                                                        backgroundColor: Colors
                                                            .white
                                                            // ignore: deprecated_member_use
                                                            .withOpacity(0.3),
                                                        bufferedColor: Colors
                                                            .white
                                                            // ignore: deprecated_member_use
                                                            .withOpacity(0.6),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              ),

                              SizedBox(height: videoButtonSpacing),

                              // Botão play/pause responsivo
                              Container(
                                width: isPhone
                                    ? 56.w
                                    : isTablet
                                        ? 64.w
                                        : 72.w,
                                height: isPhone
                                    ? 56.w
                                    : isTablet
                                        ? 64.w
                                        : 72.w,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      _controller.value.isPlaying
                                          ? _controller.pause()
                                          : _controller.play();
                                    });
                                  },
                                  backgroundColor: Colors.orange,
                                  elevation: isPhone ? 6 : 8,
                                  child: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: fabSize,
                                  ),
                                ),
                              ),

                              // Espaçamento inferior responsivo
                              SizedBox(
                                  height: isPhone
                                      ? 16.h
                                      : isTablet
                                          ? 24.h
                                          : 32.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
