import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/app/route_observer.dart';
import 'package:glicogotas_app/core/audio/audio_controller.dart';
import 'package:glicogotas_app/core/persistence/reading_progress_store.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/theme/app_text_styles.dart';
import 'package:glicogotas_app/core/ui/asset_precache.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/system_bars_style.dart';
import 'package:glicogotas_app/features/book/domain/book_chapter.dart';
import 'package:glicogotas_app/features/book/domain/book_page_content.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';
import 'package:provider/provider.dart';

class BookReaderPage extends StatefulWidget {
  const BookReaderPage({
    super.key,
    required this.chapter,
  });

  final BookChapter chapter;

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage>
    with RouteAware, PageAudioMixin<BookReaderPage> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  int _currentPage = 0;
  bool _didPrecache = false;

  BookPageContent get _page => widget.chapter.pages[_currentPage];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    initPageAudio(context.read<SettingsRepository>(), _page.audioAsset);
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
    if (index < 0 || index >= widget.chapter.pages.length) return;
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
    context.read<ReadingProgressStore>().setDiabetesPage(index);
    audioController.play(widget.chapter.pages[index].audioAsset);
  }

  void _precacheAround(int index) {
    for (final pageIndex in [index - 1, index, index + 1]) {
      if (pageIndex < 0 || pageIndex >= widget.chapter.pages.length) continue;
      final page = widget.chapter.pages[pageIndex];
      precacheLocalAsset(context, page.backgroundAsset);
      for (final layer in page.layers) {
        precacheLocalAsset(context, layer.asset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentPageNotifier,
      builder: (context, currentPage, child) {
        final barsStyle = _BookSystemBarsStyle.fromPage(
          widget.chapter.pages[currentPage],
        );

        return SystemBarsStyle(
          statusBarColor: barsStyle.statusBarColor,
          navigationBarColor: barsStyle.navigationBarColor,
          child: Scaffold(
            backgroundColor: AppColors.blue,
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ValueListenableBuilder<int>(
                      valueListenable: _currentPageNotifier,
                      builder: (context, currentPage, child) {
                        return _BookBackground(
                          page: widget.chapter.pages[currentPage],
                        );
                      },
                    ),
                  ),
                  PageView.builder(
                    controller: _pageController,
                    itemCount: widget.chapter.pages.length,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      return BookPageLayout(
                        page: widget.chapter.pages[index],
                      );
                    },
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: _currentPageNotifier,
                    builder: (context, currentPage, child) {
                      final page = widget.chapter.pages[currentPage];
                      final controlsColor =
                          page.isCover ? Colors.white : AppColors.blue;
                      return Stack(
                        children: [
                          Positioned(
                            top: 40.h,
                            left: 16.w,
                            child: IconButton(
                              iconSize: 30.sp,
                              icon: Icon(
                                Icons.menu_book,
                                color: controlsColor,
                              ),
                              onPressed: () => Navigator.pop(context),
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
                            bottom: 16.h,
                            left: 0,
                            right: 0,
                            child: _BookPageDots(
                              count: widget.chapter.pages.length,
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
                                  color: page.isCover
                                      ? Colors.yellow
                                      : AppColors.blue,
                                  size: 48.sp,
                                ),
                                onPressed: () => _goTo(currentPage - 1),
                              ),
                            ),
                          if (currentPage < widget.chapter.pages.length - 1)
                            Positioned(
                              bottom: 0.08.sh,
                              right: 20.w,
                              child: GestureDetector(
                                onTap: () => _goTo(currentPage + 1),
                                child: page.isCover
                                    ? Row(
                                        children: [
                                          Text(
                                            'Avançar',
                                            style: AppTextStyles.chewy(
                                              fontSize: 28.sp,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.yellow,
                                            size: 36.sp,
                                          ),
                                        ],
                                      )
                                    : Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.blue,
                                        size: 48.sp,
                                      ),
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

class _BookSystemBarsStyle {
  const _BookSystemBarsStyle({
    required this.statusBarColor,
    required this.navigationBarColor,
  });

  final Color statusBarColor;
  final Color navigationBarColor;

  factory _BookSystemBarsStyle.fromPage(BookPageContent page) {
    if (page.isCover) {
      return const _BookSystemBarsStyle(
        statusBarColor: AppColors.blue,
        navigationBarColor: AppColors.blue,
      );
    }

    if (page.backgroundAsset.endsWith('fundopaglivro.svg')) {
      return const _BookSystemBarsStyle(
        statusBarColor: Color(0xFFFCB44E),
        navigationBarColor: Color(0xFFFEDE74),
      );
    }

    return const _BookSystemBarsStyle(
      statusBarColor: Color(0xFF7CF0FF),
      navigationBarColor: Color(0xFF00D287),
    );
  }
}

class BookPageLayout extends StatelessWidget {
  const BookPageLayout({
    super.key,
    required this.page,
  });

  final BookPageContent page;

  @override
  Widget build(BuildContext context) {
    if (page.isCover) {
      return _BookCoverPage(page: page);
    }

    return Stack(
      children: [
        for (final layer in page.layers) _BookLayerView(layer: layer),
      ],
    );
  }
}

class _BookBackground extends StatelessWidget {
  const _BookBackground({required this.page});

  final BookPageContent page;

  @override
  Widget build(BuildContext context) {
    if (page.isCover) {
      return const ColoredBox(color: AppColors.blue);
    }

    if (page.backgroundAsset.isEmpty) {
      return ColoredBox(color: page.backgroundColor);
    }

    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: page.backgroundColor),
          SvgPicture.asset(
            page.backgroundAsset,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}

class _BookCoverPage extends StatelessWidget {
  const _BookCoverPage({required this.page});

  final BookPageContent page;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100.h),
            CustomPaint(
              painter: ArcTextPainter(),
              child: Container(height: 80.h),
            ),
            Text(
              'DESCOMPLICANDO',
              style: AppTextStyles.chewy(
                fontSize: 36.sp,
                color: Colors.yellow,
              ),
            ),
            Text(
              'o Diabetes',
              style: AppTextStyles.chewy(
                fontSize: 36.sp,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
        for (final layer in page.layers) _BookLayerView(layer: layer),
      ],
    );
  }
}

class _BookLayerView extends StatelessWidget {
  const _BookLayerView({required this.layer});

  final BookVisualLayer layer;

  @override
  Widget build(BuildContext context) {
    final width = layer.widthFactor?.sw;
    final height = layer.heightFactor?.sh;
    final child = layer.type == BookLayerType.svg
        ? SvgPicture.asset(
            layer.asset,
            width: width,
            height: height,
            fit: layer.fit,
          )
        : Image.asset(
            layer.asset,
            width: width,
            height: height,
            fit: layer.fit,
            cacheHeight: height == null
                ? null
                : (height * MediaQuery.devicePixelRatioOf(context)).round(),
          );

    return Positioned(
      top: layer.topFactor?.sh,
      bottom: layer.bottomFactor?.sh,
      left: layer.leftFactor?.sw,
      right: layer.rightFactor?.sw,
      child: RepaintBoundary(child: child),
    );
  }
}

class _BookPageDots extends StatelessWidget {
  const _BookPageDots({required this.count, required this.currentPage});

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
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: currentPage == index ? 12.w : 8.w,
          decoration: BoxDecoration(
            color: currentPage == index
                ? Colors.yellow
                : Colors.white.withAlpha(127),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}

class ArcTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final textStyle = AppTextStyles.chewy(
      fontSize: 50,
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    );

    const text = 'GLICOGOTAS';
    final radius = size.width / 4;
    final centerX = size.width / 2;
    final centerY = size.height / 1.2;

    final startAngle = -pi / 2 - (160 * pi / 180) / 2;
    const totalAngle = 160 * pi / 180;
    const anglePerLetter = totalAngle / (text.length - 1);

    for (var i = 0; i < text.length; i++) {
      final angle = startAngle + (i * anglePerLetter);
      final offset = Offset(
        centerX + radius * cos(angle),
        centerY + radius * sin(angle),
      );

      textPainter.text = TextSpan(text: text[i], style: textStyle);
      textPainter.layout();

      canvas
        ..save()
        ..translate(offset.dx, offset.dy)
        ..rotate(angle + pi / 2);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
