import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/app/app_routes.dart';
import 'package:glicogotas_app/app/route_observer.dart';
import 'package:glicogotas_app/core/audio/audio_controller.dart';
import 'package:glicogotas_app/core/theme/app_assets.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/features/book/presentation/book_chapters_page.dart';
import 'package:glicogotas_app/features/characters/presentation/characters_page.dart';
import 'package:glicogotas_app/features/comics/presentation/comics_page.dart';
import 'package:glicogotas_app/features/games/presentation/games_page.dart';
import 'package:glicogotas_app/features/home/domain/home_menu_item.dart';
import 'package:glicogotas_app/features/home/presentation/home_menu_button.dart';
import 'package:glicogotas_app/features/myths_truths/presentation/myths_truths_page.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';
import 'package:glicogotas_app/features/video/presentation/video_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with RouteAware, WidgetsBindingObserver, PageAudioMixin<HomePage> {
  bool _isCurrentPage = true;

  List<HomeMenuItem> get _items => [
        HomeMenuItem(
          label: 'Personagens',
          color: AppColors.green,
          icon: Icons.people,
          routeName: AppRoutes.characters,
          builder: (_) => const CharactersPage(),
        ),
        HomeMenuItem(
          label: 'Livro',
          color: Colors.blue,
          icon: Icons.menu_book,
          routeName: AppRoutes.bookChapters,
          builder: (_) => const BookChaptersPage(),
        ),
        HomeMenuItem(
          label: 'Mitos ou Verdades',
          color: AppColors.pink,
          icon: Icons.quiz,
          routeName: AppRoutes.mythsTruths,
          builder: (_) => const MythsTruthsPage(),
        ),
        HomeMenuItem(
          label: 'Tirinhas',
          color: AppColors.sky,
          icon: Icons.collections,
          routeName: AppRoutes.comics,
          builder: (_) => const ComicsPage(),
        ),
        HomeMenuItem(
          label: 'Vídeo',
          color: Colors.orange,
          icon: Icons.play_circle,
          routeName: AppRoutes.video,
          builder: (_) => const VideoPage(),
        ),
        HomeMenuItem(
          label: 'Jogos',
          color: Colors.deepPurple,
          icon: Icons.sports_esports,
          routeName: AppRoutes.games,
          builder: (_) => const GamesPage(),
        ),
      ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    initPageAudio(context.read<SettingsRepository>(), AppAssets.musicaHome);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    disposePageAudio();
    super.dispose();
  }

  void _navigateTo(HomeMenuItem item) {
    _isCurrentPage = false;
    audioController.stop();
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: item.routeName),
        builder: item.builder,
      ),
    );
  }

  @override
  void didPushNext() {
    _isCurrentPage = false;
    audioController.stop();
  }

  @override
  void didPopNext() {
    _isCurrentPage = true;
    audioController.resume();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      audioController.stop();
    } else if (state == AppLifecycleState.resumed && _isCurrentPage) {
      audioController.resume();
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

          const columns = 2;
          final gridHPad = 22.w;
          final crossSpacing = 16.w;
          final usableWidth =
              constraints.maxWidth - (gridHPad * 2) - crossSpacing;
          var itemSide = usableWidth / columns;
          final maxSide = constraints.maxHeight * 0.16;
          final minSide = 92.w;
          if (itemSide > maxSide) itemSide = maxSide;
          if (itemSide < minSide) itemSide = minSide;

          return Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SvgPicture.asset(AppAssets.decoracao),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  right: 16.w,
                  child: IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(Icons.settings, color: AppColors.blue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const ConfigDialog(),
                      );
                    },
                  ),
                ),
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
                            AppAssets.talitaIcon,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Como vamos',
                              style: GoogleFonts.sansitaSwashed(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.sky,
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
                                    style: TextStyle(color: AppColors.pink),
                                  ),
                                  TextSpan(
                                    text: 'hoje?',
                                    style: TextStyle(color: AppColors.sky),
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
                Positioned(
                  top: 250.h,
                  left: 0,
                  right: 0,
                  bottom: 20.h,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: gridHPad),
                    itemCount: _items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: crossSpacing,
                      mainAxisSpacing: 18.h,
                      mainAxisExtent: itemSide,
                    ),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return HomeMenuButton(
                        onTap: () => _navigateTo(item),
                        color: item.color,
                        label: item.label,
                        icon: item.icon,
                      );
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
