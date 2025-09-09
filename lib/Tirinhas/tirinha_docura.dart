import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/configuracoes.dart';

class Tirinha extends StatefulWidget {
  const Tirinha({super.key});

  @override
  TirinhaState createState() => TirinhaState();
}

class TirinhaState extends State<Tirinha> {
  final List<String> tirinha = [
    'assets/images/tirinha1.png',
    'assets/images/tirinha2.png',
    'assets/images/tirinha3.png',
  ];

  int currentIndex = 0;

  // Controlador para a navegação por arrasto
  final PageController _pageController = PageController();

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
              // Fundo com a imagem SVG
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/fundo-hist.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                children: [
                  // Linha com o título e os ícones no topo da tela
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 18.h,
                    ),
                    child: Row(
                      children: [
                        // Ícone de seta de voltar
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(Icons.style, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Spacer(),
                        // Ícone de engrenagem
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(Icons.settings, color: Colors.black),
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
                    child: Stack(
                      children: [
                        // Exibição das imagens com navegação por arrasto
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.5.h), // Ajuste o valor conforme necessário
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: tirinha.length,
                            onPageChanged: _onPageChanged,
                            itemBuilder: (context, index) {
                              return Image.asset(
                                tirinha[index],
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),

                        // Botão para navegar para a página anterior
                        Positioned(
                          bottom: 50.h,
                          left: 20.w,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_rounded,
                                size: 48.sp,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            onPressed: () {
                              _navigateToPage(currentIndex - 1);
                            },
                          ),
                        ),

                        // Botão para navegar para a próxima página
                        Positioned(
                          bottom: 50.h,
                          right: 20.w,
                          child: currentIndex < tirinha.length - 1
                              ? IconButton(
                                  icon: Icon(Icons.arrow_forward_ios_rounded,
                                      size: 48.sp,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                  onPressed: () {
                                    _navigateToPage(currentIndex + 1);
                                  },
                                )
                              : const SizedBox
                                  .shrink(), // Widget vazio quando na última página
                        ),
                      ],
                    ),
                  ),

                  // Indicadores de página (dots)
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
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
            ],
          );
        },
      ),
    );
  }
}
