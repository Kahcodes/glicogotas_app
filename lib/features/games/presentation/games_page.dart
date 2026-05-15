import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/navigation/app_navigator.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/core/theme/app_text_styles.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/system_bars_style.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemBarsStyle(
      statusBarColor: Colors.white,
      navigationBarColor: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    icon: const Icon(Icons.home_rounded),
                    color: AppColors.pink,
                    onPressed: () => AppNavigator.goHome(context),
                  ),
                  Text(
                    'Jogos',
                    style: AppTextStyles.chewy(
                      fontSize: 24.sp,
                      color: AppColors.pink,
                    ),
                  ),
                  IconButton(
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
                ],
              ),
            ),
            Positioned(
              bottom: 0.08.sh,
              left: 20.w,
              right: 20.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ah não, você chegou antes da surpresa ficar pronta!\nLogo, logo, teremos algo incrível aqui só para você!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.chewy(
                      fontSize: 14.sp,
                      color: AppColors.sky,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  RepaintBoundary(
                    child: SvgPicture.asset(
                      'assets/images/error.svg',
                      width: 320.w,
                      height: 320.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
