import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/core/navigation/app_navigator.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/theme/app_text_styles.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/system_bars_style.dart';
import 'package:glicogotas_app/features/book/data/book_chapters.dart';
import 'package:glicogotas_app/features/book/domain/book_chapter.dart';
import 'package:glicogotas_app/features/book/presentation/book_reader_page.dart';

class BookChaptersPage extends StatelessWidget {
  const BookChaptersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemBarsStyle(
      statusBarColor: const Color(0xFFEAF7FF),
      navigationBarColor: const Color(0xFFEAF7FF),
      child: Scaffold(
        backgroundColor: const Color(0xFFEAF7FF),
        body: Stack(
          children: [
            Positioned(
              top: 40.h,
              left: 16.w,
              right: 16.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(
                      Icons.home_rounded,
                      color: AppColors.blue,
                    ),
                    onPressed: () {
                      AppNavigator.goHome(context);
                    },
                  ),
                  Text(
                    'Selecione um Capítulo',
                    style: AppTextStyles.chewy(
                      color: AppColors.blue,
                      fontSize: 24.sp,
                    ),
                  ),
                  IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(
                      Icons.settings,
                      color: AppColors.blue,
                    ),
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
            Padding(
              padding: EdgeInsets.only(top: 120.h),
              child: GridView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: bookChapters.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemBuilder: (context, index) {
                  return _ChapterCard(chapter: bookChapters[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChapterCard extends StatelessWidget {
  const _ChapterCard({required this.chapter});

  final BookChapter chapter;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: chapter.title,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookReaderPage(chapter: chapter),
            ),
          );
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: RepaintBoundary(
            child: Image.asset(
              chapter.coverAsset,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              cacheHeight: 420,
            ),
          ),
        ),
      ),
    );
  }
}
