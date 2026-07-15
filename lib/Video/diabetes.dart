// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDiabetesPage extends StatefulWidget {
  const VideoDiabetesPage({super.key});

  @override
  State<VideoDiabetesPage> createState() => _VideoDiabetesPageState();
}

class _VideoDiabetesPageState extends State<VideoDiabetesPage>
    with WidgetsBindingObserver {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'Ohb8ur_wRr8',
      autoPlay: false,
      params: const YoutubePlayerParams(
        enableCaption: false,
        strictRelatedVideos: true,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _controller.pauseVideo();
    }
  }

  void _navigateBack() {
    _controller.pauseVideo();
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

                Flexible(
                  child: Container(
                    width: 320.w,
                    constraints: BoxConstraints(maxHeight: 220.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: YoutubePlayer(
                        controller: _controller,
                        aspectRatio: 16 / 9,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
