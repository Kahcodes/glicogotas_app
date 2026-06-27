import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/configuracoes.dart';

class TirinhaGlicoamigos extends StatefulWidget {
  const TirinhaGlicoamigos({super.key});

  @override
  TirinhaGlicoamigosState createState() => TirinhaGlicoamigosState();
}

class TirinhaGlicoamigosState extends State<TirinhaGlicoamigos> {
  final List<String> tirinha = [
    'assets/images/glicoamigos1.svg',
    'assets/images/glicoamigos2.png',
    'assets/images/glicoamigos3.svg',
    'assets/images/glicoamigos4.svg',
    'assets/images/glicoamigos5.svg',
    'assets/images/glicoamigos6.svg',
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

  Widget _buildImagemTirinha(String path) {
    if (path.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        fit: BoxFit.contain,
      );
    }

    return Image.asset(
      path,
      fit: BoxFit.contain,
    );
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 18.h,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(
                            Icons.style,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),

                        const Spacer(),

                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ConfigDialog();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: tirinha.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double scale = 1.0;
                            double opacity = 1.0;

                            if (_pageController.position.haveDimensions) {
                              final double page =
                                  _pageController.page ?? currentIndex.toDouble();

                              scale = (1 - (index - page).abs()).clamp(0.85, 1.0);
                              opacity = (1 - (index - page).abs()).clamp(0.0, 1.0);
                            }

                            return Center(
                              child: Transform.scale(
                                scale: scale,
                                child: Opacity(
                                  opacity: opacity,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24.w,
                                    ),
                                    child: _buildImagemTirinha(tirinha[index]),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 16.h, bottom: 20.h),
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
                            color: currentIndex == index
                                ? Colors.black
                                : Colors.grey,
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
                child: currentIndex > 0
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 48.sp,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          _navigateToPage(currentIndex - 1);
                        },
                      )
                    : const SizedBox.shrink(),
              ),

              Positioned(
                bottom: 50.h,
                right: 20.w,
                child: currentIndex < tirinha.length - 1
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 48.sp,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          _navigateToPage(currentIndex + 1);
                        },
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