import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/navigation/app_navigator.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/outlined_text.dart';

class CharactersIntroPage extends StatelessWidget {
  const CharactersIntroPage({
    super.key,
    required this.onNext,
  });

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(
          context,
          designSize: const Size(360, 690),
          minTextAdapt: true,
        );

        return Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/fundo-azul.svg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40.h,
              left: 16.w,
              child: IconButton(
                iconSize: 30.sp,
                icon: const Icon(Icons.home_rounded, color: Colors.white),
                onPressed: () => AppNavigator.goHome(context),
              ),
            ),
            Positioned(
              top: 40.h,
              right: 16.w,
              child: IconButton(
                iconSize: 30.sp,
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const ConfigDialog(),
                  );
                },
              ),
            ),
            Positioned(
              top: 0.05.sh,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    OutlinedText(
                      text: 'Bem-Vindos',
                      fontSize: 0.13.sw,
                      color: AppColors.pink,
                      strokeWidth: 8,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha((0.25 * 255).toInt()),
                          offset: const Offset(3, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    OutlinedText(
                      text: 'À Turminha do Glicogotas!',
                      fontSize: 0.06.sw,
                      color: AppColors.pink,
                      strokeWidth: 5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha((0.25 * 255).toInt()),
                          offset: const Offset(3, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0.20.sh,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/images/tela-inicial-perso.svg',
                width: 1.sw,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.05.sh,
              right: 20.w,
              child: GestureDetector(
                onTap: onNext,
                child: Row(
                  children: [
                    OutlinedText(
                      text: 'Avançar',
                      fontSize: 26.sp,
                      color: AppColors.pink,
                      strokeWidth: 5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha((0.25 * 255).toInt()),
                          offset: const Offset(3, 3),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: const Color(0xfff6aebf),
                      size: 38.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
