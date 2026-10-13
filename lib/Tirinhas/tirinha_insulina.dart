import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_app/configuracoes.dart';

class TirinhaInsulina extends StatefulWidget {
  const TirinhaInsulina({super.key});

  @override
  TirinhaInsulinaState createState() => TirinhaInsulinaState();
}

class TirinhaInsulinaState extends State<TirinhaInsulina> {
  final List<String> tirinha = [
    'assets/images/tirinha-ins-1.svg',
    'assets/images/tirinha-ins-2.svg',
    'assets/images/tirinha-ins-3.svg',
  ];

  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _navigateToPage(int index) {
    if (index >= 0 && index < tirinha.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildTirinha(String path) {
    if (path.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(path, fit: BoxFit.contain);
    }
    return Image.asset(path, fit: BoxFit.contain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3F6),
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
                  'assets/images/fundo-hist.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(Icons.style, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(Icons.settings, color: Colors.black),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const ConfigDialog(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // Posição e tamanho padronizados para todas as tirinhas.
                  SizedBox(height: 40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'Insulina',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        fontSize: 28.sp,
                        color: const Color(0xFF37ABDC),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: tirinha.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        return _buildTirinha(tirinha[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        tirinha.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 8.h,
                          width: 8.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex == index ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 50.h,
                left: 20.w,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, size: 48.sp, color: Colors.black),
                  onPressed: currentIndex > 0 ? () => _navigateToPage(currentIndex - 1) : null,
                ),
              ),
              Positioned(
                bottom: 50.h,
                right: 20.w,
                child: currentIndex < tirinha.length - 1
                    ? IconButton(
                        icon: Icon(Icons.arrow_forward_ios_rounded, size: 48.sp, color: Colors.black),
                        onPressed: () => _navigateToPage(currentIndex + 1),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}
