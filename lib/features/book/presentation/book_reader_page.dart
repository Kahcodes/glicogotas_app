import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/app/route_observer.dart';
import 'package:glicogotas_app/core/audio/audio_controller.dart';
import 'package:glicogotas_app/core/persistence/reading_progress_store.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/features/book/domain/book_chapter.dart';
import 'package:glicogotas_app/features/book/domain/book_page_content.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int _currentPage = 0;

  BookPageContent get _page => widget.chapter.pages[_currentPage];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    initPageAudio(context.read<SettingsRepository>(), _page.audioAsset);
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
    if (index < 0 || index >= widget.chapter.pages.length) return;
    final progressStore = context.read<ReadingProgressStore>();
    await audioController.stop();
    await progressStore.setDiabetesPage(index);
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    context.read<ReadingProgressStore>().setDiabetesPage(index);
    audioController.play(widget.chapter.pages[index].audioAsset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.chapter.pages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return BookPageLayout(
                  page: widget.chapter.pages[index],
                  onBackToChapters: () => Navigator.pop(context),
                  onSettings: () {
                    showDialog(
                      context: context,
                      builder: (_) => const ConfigDialog(),
                    );
                  },
                );
              },
            ),
            Positioned(
              bottom: 16.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.chapter.pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 8.h,
                    width: _currentPage == index ? 12.w : 8.w,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.yellow
                          : Colors.white.withAlpha(127),
                      borderRadius: BorderRadius.circular(4.r),
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
                    color: _page.isCover ? Colors.yellow : AppColors.blue,
                    size: 48.sp,
                  ),
                  onPressed: () => _goTo(_currentPage - 1),
                ),
              ),
            if (_currentPage < widget.chapter.pages.length - 1)
              Positioned(
                bottom: 0.08.sh,
                right: 20.w,
                child: GestureDetector(
                  onTap: () => _goTo(_currentPage + 1),
                  child: _page.isCover
                      ? Row(
                          children: [
                            Text(
                              'Avançar',
                              style: GoogleFonts.chewy(
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
        ),
      ),
    );
  }
}

class BookPageLayout extends StatelessWidget {
  const BookPageLayout({
    super.key,
    required this.page,
    required this.onBackToChapters,
    required this.onSettings,
  });

  final BookPageContent page;
  final VoidCallback onBackToChapters;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(
          context,
          designSize: const Size(360, 690),
          minTextAdapt: true,
        );

        if (page.isCover) {
          return _BookCoverPage(
            page: page,
            onBackToChapters: onBackToChapters,
            onSettings: onSettings,
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: page.backgroundAsset.isEmpty
                  ? ColoredBox(color: page.backgroundColor)
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        ColoredBox(color: page.backgroundColor),
                        SvgPicture.asset(
                          page.backgroundAsset,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
            ),
            for (final layer in page.layers) _BookLayerView(layer: layer),
            Positioned(
              top: 40.h,
              left: 16.w,
              child: IconButton(
                iconSize: 30.sp,
                icon: const Icon(Icons.menu_book, color: AppColors.blue),
                onPressed: onBackToChapters,
              ),
            ),
            Positioned(
              top: 40.h,
              right: 16.w,
              child: IconButton(
                iconSize: 30.sp,
                icon: const Icon(Icons.settings, color: AppColors.blue),
                onPressed: onSettings,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BookCoverPage extends StatelessWidget {
  const _BookCoverPage({
    required this.page,
    required this.onBackToChapters,
    required this.onSettings,
  });

  final BookPageContent page;
  final VoidCallback onBackToChapters;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: AppColors.blue),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h, left: 16.w),
              child: IconButton(
                iconSize: 30.sp,
                icon: const Icon(Icons.menu_book, color: Colors.white),
                onPressed: onBackToChapters,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.h, right: 16.w),
              child: IconButton(
                iconSize: 30.sp,
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: onSettings,
              ),
            ),
          ],
        ),
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
              style: GoogleFonts.chewy(
                fontSize: 36.sp,
                color: Colors.yellow,
              ),
            ),
            Text(
              'o Diabetes',
              style: GoogleFonts.chewy(
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
          );

    return Positioned(
      top: layer.topFactor?.sh,
      bottom: layer.bottomFactor?.sh,
      left: layer.leftFactor?.sw,
      right: layer.rightFactor?.sw,
      child: child,
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

    final textStyle = GoogleFonts.chewy(
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
