import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/core/navigation/app_navigator.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/features/book/data/diabetes_chapter.dart';
import 'package:glicogotas_app/features/book/presentation/book_reader_page.dart';
import 'package:google_fonts/google_fonts.dart';

class BookChaptersPage extends StatelessWidget {
  const BookChaptersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
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
                      style: GoogleFonts.chewy(
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
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16.w),
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BookReaderPage(
                              chapter: diabetesChapter,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          diabetesChapter.coverAsset,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
