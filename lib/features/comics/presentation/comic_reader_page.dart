import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/features/comics/domain/comic.dart';

class ComicReaderPage extends StatelessWidget {
  const ComicReaderPage({super.key, required this.comic});

  final Comic comic;

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
              itemCount: comic.pages.length,
              itemBuilder: (context, index) {
                final asset = comic.pages[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 84.h, 20.w, 48.h),
                  child: Center(
                    child: asset.endsWith('.svg')
                        ? SvgPicture.asset(asset, fit: BoxFit.contain)
                        : Image.asset(asset, fit: BoxFit.contain),
                  ),
                );
              },
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
