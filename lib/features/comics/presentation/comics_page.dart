import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/app/app_routes.dart';
import 'package:glicogotas_app/core/navigation/app_navigator.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/theme/app_text_styles.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/system_bars_style.dart';
import 'package:glicogotas_app/features/comics/data/comics.dart';
import 'package:glicogotas_app/features/comics/domain/comic.dart';
import 'package:glicogotas_app/features/comics/presentation/comic_reader_page.dart';

class ComicsPage extends StatelessWidget {
  const ComicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemBarsStyle(
      statusBarColor: const Color(0xFFFFF3F6),
      navigationBarColor: const Color(0xFFFFF3F6),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF3F6),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 30.sp,
                      icon:
                          const Icon(Icons.home_rounded, color: AppColors.pink),
                      onPressed: () => AppNavigator.goHome(context),
                    ),
                    Text(
                      'Selecione uma tirinha',
                      style: AppTextStyles.chewy(
                        color: AppColors.sky,
                        fontSize: 24.sp,
                      ),
                    ),
                    IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(Icons.settings, color: AppColors.pink),
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
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: comics.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                  ),
                  itemBuilder: (context, index) {
                    return _ComicCard(comic: comics[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComicCard extends StatelessWidget {
  const _ComicCard({required this.comic});

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: comic.title,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(name: '${AppRoutes.comics}/${comic.id}'),
              builder: (_) => ComicReaderPage(comic: comic),
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
              comic.coverAsset,
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
