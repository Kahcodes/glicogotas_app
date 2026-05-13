import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/app/route_observer.dart';
import 'package:glicogotas_app/core/audio/audio_controller.dart';
import 'package:glicogotas_app/core/navigation/app_navigator.dart';
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
  int _currentPage = 0;

  int get _pageCount => characterProfiles.length + 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    initPageAudio(
      context.read<SettingsRepository>(),
      'audio/audioPersonagens/bemvindos.mp3',
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    disposePageAudio();
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
    await audioController.stop();
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    final audioAsset = index == 0
        ? 'audio/audioPersonagens/bemvindos.mp3'
        : characterProfiles[index - 1].audioAsset;
    audioController.play(audioAsset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF265F95),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pageCount,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CharactersIntroPage(
                    onNext: () => _goTo(1),
                  );
                }

                return CharacterDetailPage(
                  profile: characterProfiles[index - 1],
                  onHome: () => AppNavigator.goHome(context),
                );
              },
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pageCount,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.yellow
                          : Colors.white.withAlpha((0.5 * 255).toInt()),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            if (_currentPage > 0)
              Positioned(
                bottom: 0.08.sh,
                left: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: _currentPage == 0
                        ? Colors.white
                        : characterProfiles[_currentPage - 1].color,
                    size: 48.sp,
                  ),
                  onPressed: () => _goTo(_currentPage - 1),
                ),
              ),
            if (_currentPage < _pageCount - 1)
              Positioned(
                bottom: 0.08.sh,
                right: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: _currentPage == 0
                        ? const Color(0xfff6aebf)
                        : characterProfiles[_currentPage - 1].color,
                    size: 48.sp,
                  ),
                  onPressed: () => _goTo(_currentPage + 1),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
