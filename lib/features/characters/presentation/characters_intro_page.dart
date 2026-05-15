import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/ui/outlined_text.dart';

class CharactersIntroPage extends StatelessWidget {
  const CharactersIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          child: RepaintBoundary(
            child: SvgPicture.asset(
              'assets/images/tela-inicial-perso.svg',
              width: 1.sw,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
