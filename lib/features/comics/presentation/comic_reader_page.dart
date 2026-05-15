import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/asset_precache.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/system_bars_style.dart';
import 'package:glicogotas_app/features/comics/domain/comic.dart';

class ComicReaderPage extends StatefulWidget {
  const ComicReaderPage({super.key, required this.comic});

  final Comic comic;

  @override
  State<ComicReaderPage> createState() => _ComicReaderPageState();
}

class _ComicReaderPageState extends State<ComicReaderPage> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  bool _didPrecache = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didPrecache) return;
    _didPrecache = true;
    _precacheAround(0);
  }

  @override
  void dispose() {
    _currentPage.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToPage(int index) async {
    if (index < 0 || index >= widget.comic.pages.length) return;
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    _currentPage.value = index;
    _precacheAround(index);
  }

  void _precacheAround(int index) {
    for (final pageIndex in [index - 1, index, index + 1]) {
      if (pageIndex < 0 || pageIndex >= widget.comic.pages.length) continue;
      final asset = widget.comic.pages[pageIndex];
      precacheLocalAsset(context, asset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SystemBarsStyle(
      statusBarColor: const Color(0xFFCC6AE5),
      navigationBarColor: const Color(0xFFCC6AE5),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF3F6),
        body: Stack(
          children: [
            Positioned.fill(
              child: RepaintBoundary(
                child: SvgPicture.asset(
                  'assets/images/fundo-hist.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SafeArea(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.comic.pages.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final asset = widget.comic.pages[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(12.w, 84.h, 12.w, 64.h),
                    child: Center(
                      child: _ComicPageAsset(asset: asset),
                    ),
                  );
                },
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (context, currentPage, child) {
                return Stack(
                  children: [
                    Positioned(
                      bottom: 22.h,
                      left: 0,
                      right: 0,
                      child: _ComicPageDots(
                        count: widget.comic.pages.length,
                        currentPage: currentPage,
                      ),
                    ),
                    if (currentPage > 0)
                      Positioned(
                        bottom: 0.10.sh,
                        left: 8.w,
                        child: _ComicNavButton(
                          icon: Icons.arrow_back_ios_rounded,
                          onTap: () => _goToPage(currentPage - 1),
                        ),
                      ),
                    if (currentPage < widget.comic.pages.length - 1)
                      Positioned(
                        bottom: 0.10.sh,
                        right: 8.w,
                        child: _ComicNavButton(
                          icon: Icons.arrow_forward_ios_rounded,
                          onTap: () => _goToPage(currentPage + 1),
                        ),
                      ),
                  ],
                );
              },
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
          ],
        ),
      ),
    );
  }
}

class _ComicPageAsset extends StatelessWidget {
  const _ComicPageAsset({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    if (asset.endsWith('.svg')) {
      return RepaintBoundary(
        child: SvgPicture.asset(
          asset,
          width: 1.sw,
          height: 1.sh,
          fit: BoxFit.contain,
          placeholderBuilder: (_) => const Center(
            child: CircularProgressIndicator(color: AppColors.pink),
          ),
        ),
      );
    }

    return RepaintBoundary(
      child: Image.asset(
        asset,
        width: 1.sw,
        height: 1.sh,
        fit: BoxFit.contain,
        cacheHeight: (MediaQuery.sizeOf(context).height *
                MediaQuery.devicePixelRatioOf(context))
            .round(),
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.broken_image,
            color: AppColors.pink,
            size: 48,
          );
        },
      ),
    );
  }
}

class _ComicPageDots extends StatelessWidget {
  const _ComicPageDots({required this.count, required this.currentPage});

  final int count;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: index == currentPage ? 14.w : 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: index == currentPage
                ? AppColors.pink
                : Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }
}

class _ComicNavButton extends StatelessWidget {
  const _ComicNavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.85),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 48.w,
          height: 48.w,
          child: Icon(icon, color: AppColors.pink, size: 30.sp),
        ),
      ),
    );
  }
}
