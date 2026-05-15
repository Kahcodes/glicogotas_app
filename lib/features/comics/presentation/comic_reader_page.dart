import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/features/comics/domain/comic.dart';

class ComicReaderPage extends StatefulWidget {
  const ComicReaderPage({super.key, required this.comic});

  final Comic comic;

  @override
  State<ComicReaderPage> createState() => _ComicReaderPageState();
}

class _ComicReaderPageState extends State<ComicReaderPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3F6),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundo-hist.svg',
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.comic.pages.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
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
          Positioned(
            bottom: 22.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.comic.pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: index == _currentPage ? 14.w : 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: index == _currentPage
                        ? AppColors.pink
                        : Colors.white.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ),
          if (_currentPage > 0)
            Positioned(
              bottom: 0.10.sh,
              left: 8.w,
              child: _ComicNavButton(
                icon: Icons.arrow_back_ios_rounded,
                onTap: () => _goToPage(_currentPage - 1),
              ),
            ),
          if (_currentPage < widget.comic.pages.length - 1)
            Positioned(
              bottom: 0.10.sh,
              right: 8.w,
              child: _ComicNavButton(
                icon: Icons.arrow_forward_ios_rounded,
                onTap: () => _goToPage(_currentPage + 1),
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
        ],
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
      return SvgPicture.asset(
        asset,
        width: 1.sw,
        height: 1.sh,
        fit: BoxFit.contain,
        placeholderBuilder: (_) => const Center(
          child: CircularProgressIndicator(color: AppColors.pink),
        ),
      );
    }

    return Image.asset(
      asset,
      width: 1.sw,
      height: 1.sh,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.broken_image, color: AppColors.pink, size: 48);
      },
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
