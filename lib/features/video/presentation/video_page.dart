import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/features/video/data/app_videos.dart';
import 'package:glicogotas_app/features/video/domain/app_video.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return VideoPlayerPage(video: appVideos[0]);
  }
}

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key, required this.video});

  final AppVideo video;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage>
    with WidgetsBindingObserver {
  late final VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = VideoPlayerController.asset(widget.video.asset)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        _controller.play();
      });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _controller.pause();
    }
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
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundopaglivro.svg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 40.h,
            left: 16.w,
            child: IconButton(
              iconSize: 30.sp,
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: AppColors.pink,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 40.h,
            right: 16.w,
            child: IconButton(
              iconSize: 30.sp,
              icon: const Icon(Icons.settings),
              color: AppColors.pink,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const ConfigDialog(),
                );
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.video.title,
                  style: GoogleFonts.chewy(
                    color: Colors.orange,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                SizedBox(
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
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 8.h,
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
                SizedBox(height: 20.h),
                SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: FloatingActionButton(
                    backgroundColor: Colors.orange,
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 30.sp,
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
