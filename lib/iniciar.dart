import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

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
              // Fundo com as ondinhas
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/decoracao.svg',
                  fit: BoxFit.fill,
                ),
              ),

              // Conteúdo centralizado
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Logo
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(
                        'assets/images/glicogotas_logo.png',
                        height: 407,
                      ),
                    ),

                    // Texto abaixo do logo
                    SizedBox(
                      width: 300.w,
                      height: 29.h,
                      child: Text(
                        'Desvendando o Diabetes',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sansitaSwashed(
                          color: const Color(0xFF265F95),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                        ),
                      ),
                    ),

                    SizedBox(height: 38.h),

                    // Botão INICIAR com acessibilidade fixa
                    MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaler: const TextScaler.linear(1.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TelaHome(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D287),
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