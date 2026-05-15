import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/app/route_observer.dart';
import 'package:glicogotas_app/core/audio/audio_controller.dart';
import 'package:glicogotas_app/core/navigation/app_navigator.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/asset_precache.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/outlined_text.dart';
import 'package:glicogotas_app/core/ui/system_bars_style.dart';
import 'package:glicogotas_app/features/characters/data/character_profiles.dart';
import 'package:glicogotas_app/features/characters/presentation/character_detail_page.dart';
import 'package:glicogotas_app/features/characters/presentation/characters_intro_page.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';
import 'package:provider/provider.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage>
    with RouteAware, PageAudioMixin<CharactersPage> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  int _currentPage = 0;
  bool _didPrecache = false;

  int get _pageCount => characterProfiles.length + 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    initPageAudio(
      context.read<SettingsRepository>(),
      'audio/audioPersonagens/bemvindos.mp3',
    );
    if (!_didPrecache) {
      _didPrecache = true;
      _precacheAround(0);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    disposePageAudio();
    _currentPageNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    audioController.stop();
  }

  @override
  void didPopNext() {
    audioController.resume();
  }

  Future<void> _goTo(int index) async {
    if (index < 0 || index >= _pageCount) return;
    if (index == _currentPage) return;
    await audioController.stop();
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    _currentPage = index;
    _currentPageNotifier.value = index;
    _precacheAround(index);
    final audioAsset = index == 0
        ? 'audio/audioPersonagens/bemvindos.mp3'
        : characterProfiles[index - 1].audioAsset;
    audioController.play(audioAsset);
  }

  void _precacheAround(int index) {
    for (final pageIndex in [index - 1, index, index + 1]) {
      if (pageIndex < 0 || pageIndex >= _pageCount) continue;
      if (pageIndex == 0) {
        precacheLocalAsset(context, 'assets/images/fundo-azul.svg');
        precacheLocalAsset(context, 'assets/images/tela-inicial-perso.svg');
        continue;
      }

      final profile = characterProfiles[pageIndex - 1];
      precacheLocalAsset(context, profile.backgroundAsset);
      precacheLocalAsset(context, profile.orbitAsset);
      precacheLocalAsset(context, profile.characterAsset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPageNotifier,
      builder: (context, currentPage, child) {
        final barsColor = currentPage == 0
            ? const Color(0xFF23A6F0)
            : characterProfiles[currentPage - 1].color;

        return SystemBarsStyle(
          statusBarColor: barsColor,
          navigationBarColor: barsColor,
          child: Scaffold(
            backgroundColor: const Color(0xFF265F95),
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ValueListenableBuilder<int>(
                      valueListenable: _currentPageNotifier,
                      builder: (context, currentPage, child) {
                        return _CharactersBackground(currentPage: currentPage);
                      },
                    ),
                  ),
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _pageCount,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const CharactersIntroPage();
                      }

                      return CharacterDetailPage(
                        profile: characterProfiles[index - 1],
                      );
                    },
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: _currentPageNotifier,
                    builder: (context, currentPage, child) {
                      final pageColor = currentPage == 0
                          ? Colors.white
                          : characterProfiles[currentPage - 1].color;
                      final controlsColor = currentPage == 0
                          ? Colors.white
                          : const Color.fromARGB(255, 0, 132, 255);
                      return Stack(
                        children: [
                          Positioned(
                            top: 40.h,
                            left: 16.w,
                            child: IconButton(
                              iconSize: 30.sp,
                              icon: Icon(
                                Icons.home_rounded,
                                color: controlsColor,
                              ),
                              onPressed: () => AppNavigator.goHome(context),
                            ),
                          ),
                          Positioned(
                            top: 40.h,
                            right: 16.w,
                            child: IconButton(
                              iconSize: 30.sp,
                              icon: Icon(
                                Icons.settings,
                                color: controlsColor,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => const ConfigDialog(),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: _CharacterPageDots(
                              count: _pageCount,
                              currentPage: currentPage,
                            ),
                          ),
                          if (currentPage > 0)
                            Positioned(
                              bottom: 0.08.sh,
                              left: 20.w,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: pageColor,
                                  size: 48.sp,
                                ),
                                onPressed: () => _goTo(currentPage - 1),
                              ),
                            ),
                          if (currentPage < _pageCount - 1)
                            Positioned(
                              bottom: 0.08.sh,
                              right: 20.w,
                              child: currentPage == 0
                                  ? _CharactersIntroNextButton(
                                      onTap: () => _goTo(currentPage + 1),
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: pageColor,
                                        size: 48.sp,
                                      ),
                                      onPressed: () => _goTo(currentPage + 1),
                                    ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CharactersBackground extends StatelessWidget {
  const _CharactersBackground({required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final asset = currentPage == 0
        ? 'assets/images/fundo-azul.svg'
        : characterProfiles[currentPage - 1].backgroundAsset;

    return RepaintBoundary(
      child: SvgPicture.asset(
        asset,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _CharactersIntroNextButton extends StatelessWidget {
  const _CharactersIntroNextButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          OutlinedText(
            text: 'Avançar',
            fontSize: 26.sp,
            color: AppColors.pink,
            strokeWidth: 5,
            shadows: [
              Shadow(
                color: Colors.black.withAlpha((0.25 * 255).toInt()),
                offset: const Offset(3, 3),
                blurRadius: 4,
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: const Color(0xfff6aebf),
            size: 38.sp,
          ),
        ],
      ),
    );
  }
}

class _CharacterPageDots extends StatelessWidget {
  const _CharacterPageDots({required this.count, required this.currentPage});

  final int count;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentPage == index ? 12 : 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? Colors.yellow
                : Colors.white.withAlpha((0.5 * 255).toInt()),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
