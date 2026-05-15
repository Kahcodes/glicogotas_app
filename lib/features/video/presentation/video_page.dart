import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/theme/app_text_styles.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/system_bars_style.dart';
import 'package:glicogotas_app/features/video/data/app_videos.dart';
import 'package:glicogotas_app/features/video/domain/app_video.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        controlsVisibleAtStart: true,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _restorePortraitUi();
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

  Future<void> _openOnYoutube() async {
    final uri = Uri.parse(widget.video.youtubeUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _restorePortraitUi() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.orange,
      progressColors: ProgressBarColors(
        playedColor: Colors.orange,
        handleColor: Colors.orange.shade700,
      ),
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
        RemainingDuration(),
        FullScreenButton(),
      ],
    );

    return YoutubePlayerBuilder(
      player: player,
      builder: (context, player) => _VideoContent(
        video: widget.video,
        player: player,
        onOpenOnYoutube: _openOnYoutube,
      ),
    );
  }
}

class _VideoContent extends StatelessWidget {
  const _VideoContent({
    required this.video,
    required this.player,
    required this.onOpenOnYoutube,
  });

  final AppVideo video;
  final Widget player;
  final VoidCallback onOpenOnYoutube;

  @override
  Widget build(BuildContext context) {
    return SystemBarsStyle.transparent(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF4E6),
        body: Stack(
          children: [
            Positioned.fill(
              child: RepaintBoundary(
                child: SvgPicture.asset(
                  'assets/images/fundopaglivro.svg',
                  fit: BoxFit.fill,
                ),
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
                    video.title,
                    style: AppTextStyles.chewy(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: player,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      'Este vídeo precisa de internet para carregar.',
                      style: AppTextStyles.chewy(
                        color: AppColors.blue,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 8.h,
                      ),
                    ),
                    onPressed: onOpenOnYoutube,
                    icon: Icon(
                      Icons.open_in_new_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    label: Text(
                      'Abrir no YouTube',
                      style: AppTextStyles.chewy(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
