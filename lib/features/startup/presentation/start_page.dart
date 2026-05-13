import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/app/app_routes.dart';
import 'package:glicogotas_app/core/theme/app_assets.dart';
import 'package:glicogotas_app/core/theme/app_colors.dart';
import 'package:glicogotas_app/features/home/presentation/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
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
                  AppAssets.decoracao,
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Image.asset(
                        AppAssets.logo,
                        height: 407,
                      ),
                    ),
                    SizedBox(
                      width: 300.w,
                      height: 29.h,
                      child: Text(
                        'Desvendando o Diabetes',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sansitaSwashed(
                          color: AppColors.blue,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 38.h),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            settings: const RouteSettings(
                              name: AppRoutes.home,
                            ),
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                      ),
                      child: SizedBox(
                        width: 154.w,
                        height: 32.h,
                        child: Center(
                          child: Text(
                            'INICIAR',
                            style: GoogleFonts.podkova(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
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
