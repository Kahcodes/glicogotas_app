import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/audio/audio_player_service.dart';
import 'package:glicogotas_app/core/theme/app_text_styles.dart';
import 'package:glicogotas_app/core/ui/asset_precache.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/system_bars_style.dart';
import 'package:glicogotas_app/features/myths_truths/domain/myth_truth_page_content.dart';
import 'package:glicogotas_app/features/myths_truths/domain/myth_truth_topic.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';
import 'package:provider/provider.dart';

class MythsTruthsReaderPage extends StatefulWidget {
  const MythsTruthsReaderPage({super.key, required this.topic});

  final MythTruthTopic topic;

  @override
  State<MythsTruthsReaderPage> createState() => _MythsTruthsReaderPageState();
}

class _MythsTruthsReaderPageState extends State<MythsTruthsReaderPage> {
  static const _purple = Color(0xFF9C6ADE);

  late final PageController _pageController;
  late final AudioPlayerService _feedbackAudio;
  int _currentIndex = 0;
  bool? _answeredCorrectly;
  bool _answered = false;
  bool _didPrecache = false;

  MythTruthPageContent get _currentPage => widget.topic.pages[_currentIndex];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _feedbackAudio = AudioPlayerService();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didPrecache) return;
    _didPrecache = true;
    precacheLocalAsset(context, 'assets/images/fundo-mito.svg');
    precacheLocalAsset(context, 'assets/images/personagem_acerto.png');
    precacheLocalAsset(context, 'assets/images/personagem_erro.png');
  }

  @override
  void dispose() {
    _pageController.dispose();
    _feedbackAudio.dispose();
    super.dispose();
  }

  Future<void> _answer(bool answer) async {
    final correctAnswer = _currentPage.correctAnswer;
    if (correctAnswer == null || _answered) return;

    final isCorrect = correctAnswer == answer;
    setState(() {
      _answeredCorrectly = isCorrect;
      _answered = true;
    });

    final settings = context.read<SettingsRepository>();
    if (settings.soundOn) {
      await _feedbackAudio.playAsset(
        isCorrect ? 'sounds/acerto.mp3' : 'sounds/erro.mp3',
        volume: settings.volume,
      );
    }
  }

  Future<void> _nextPage() async {
    if (_currentIndex >= widget.topic.pages.length - 1) return;
    if (_currentPage.isQuestion && !_answered) return;

    setState(() {
      _currentIndex++;
      _answeredCorrectly = null;
      _answered = false;
    });
    await _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _previousPage() async {
    if (_currentIndex == 0) return;

    setState(() {
      _currentIndex--;
      _answeredCorrectly = null;
      _answered = false;
    });
    await _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    if (_currentPage.isQuestion && !_answered && index > _currentIndex) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
      return;
    }

    setState(() {
      _currentIndex = index;
      _answeredCorrectly = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final canNavigate = _answered || !_currentPage.isQuestion;

    return SystemBarsStyle(
      statusBarColor: const Color(0xFF6AE5B9),
      navigationBarColor: const Color(0xFFA166FF),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF3F6),
        body: Stack(
          children: [
            Positioned.fill(
              child: RepaintBoundary(
                child: SvgPicture.asset(
                  'assets/images/fundo-mito.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(
                            Icons.question_answer,
                            color: _purple,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(Icons.settings, color: _purple),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => const ConfigDialog(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _MythTruthTitle(fontSize: 28.sp),
                  const Spacer(),
                  SizedBox(
                    height: 0.5.sh,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: _currentPage.isQuestion && !_answered
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      onPageChanged: _onPageChanged,
                      itemCount: widget.topic.pages.length,
                      itemBuilder: (context, index) {
                        return RepaintBoundary(
                          child: _MythTruthCard(
                            page: widget.topic.pages[index],
                            isCurrentPage: index == _currentIndex,
                            answered: _answered,
                            answeredCorrectly: _answeredCorrectly,
                            onAnswer: _answer,
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  _PageDots(
                    count: widget.topic.pages.length,
                    currentIndex: _currentIndex,
                  ),
                  SizedBox(
                    height: 72.h,
                    child: canNavigate
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 42.sp,
                                  color: Colors.black,
                                ),
                                onPressed:
                                    _currentIndex > 0 ? _previousPage : null,
                              ),
                              if (_currentIndex < widget.topic.pages.length - 1)
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 42.sp,
                                    color: Colors.black,
                                  ),
                                  onPressed: _nextPage,
                                )
                              else
                                SizedBox(width: 48.w),
                            ],
                          )
                        : null,
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

class _MythTruthTitle extends StatelessWidget {
  const _MythTruthTitle({required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'MITO',
        style: AppTextStyles.chewy(
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE53935),
          ),
        ),
        children: [
          TextSpan(
            text: ' ou ',
            style: TextStyle(color: const Color(0xFF33363F)),
          ),
          TextSpan(
            text: 'VERDADE?',
            style: AppTextStyles.chewy(
              textStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF43A047),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MythTruthCard extends StatelessWidget {
  const _MythTruthCard({
    required this.page,
    required this.isCurrentPage,
    required this.answered,
    required this.answeredCorrectly,
    required this.onAnswer,
  });

  final MythTruthPageContent page;
  final bool isCurrentPage;
  final bool answered;
  final bool? answeredCorrectly;
  final ValueChanged<bool> onAnswer;

  bool get _showFeedback => page.isQuestion && isCurrentPage && answered;

  @override
  Widget build(BuildContext context) {
    final titleStyle = AppTextStyles.chewy(
      textStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: _titleColor,
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE5D4FF),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!page.isQuestion || _showFeedback) ...[
              Text(
                _title,
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18.h),
            ],
            if (!_showFeedback)
              Text(
                page.question ?? page.explanation,
                textAlign: TextAlign.center,
                style: AppTextStyles.chewy(
                  textStyle: TextStyle(
                    fontSize: page.isQuestion ? 20.sp : 18.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            if (page.isQuestion && !answered) ...[
              SizedBox(height: 28.h),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFD32F2F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      icon: const Icon(Icons.close, color: Colors.white),
                      label: Text(
                        'Mito',
                        style: AppTextStyles.chewy(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      onPressed: () => onAnswer(false),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: Text(
                        'Verdade',
                        style: AppTextStyles.chewy(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      onPressed: () => onAnswer(true),
                    ),
                  ),
                ],
              ),
            ],
            if (_showFeedback) ...[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Image.asset(
                  answeredCorrectly == true
                      ? 'assets/images/personagem_acerto.png'
                      : 'assets/images/personagem_erro.png',
                  key: ValueKey(answeredCorrectly),
                  height: 120.h,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                page.explanation,
                style: AppTextStyles.chewy(
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color get _titleColor {
    if (!_showFeedback) return const Color(0xFF5A2D82);
    return answeredCorrectly == true ? Colors.green : Colors.red;
  }

  String get _title {
    if (!_showFeedback) return page.title;
    if (answeredCorrectly == true) return 'Boa! Você acertou! ${page.title}';
    return 'Errar faz parte!';
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.currentIndex});

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex ? Colors.pink : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
