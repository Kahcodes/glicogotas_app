import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/configuracoes.dart'; // Importando a tela de configurações

class TirinhaInsulina extends StatefulWidget {
  const TirinhaInsulina({super.key});

  @override
  TirinhaInsulinaState createState() => TirinhaInsulinaState();
}

class TirinhaInsulinaState extends State<TirinhaInsulina> {
  final List<String> tirinha = [
    'assets/images/tirinha-ins-1.png',
    'assets/images/tirinha-ins-2.png',
    'assets/images/tirinha-ins-3.png',
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
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfff3f6), // Fundo da página
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
                  'assets/images/fundo-hist.svg', // Caminho da imagem SVG
                  fit: BoxFit.fill,
                ),
              ),
              // Elementos sobrepondo o fundo
              Column(
                children: [
                  // Linha com o título e os ícones no topo da tela
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 40
                          .h, // Ajuste no padding para afastar os elementos do topo
                    ),
                    child: Row(
                      children: [
                        // Ícone de seta de voltar
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(Icons.arrow_back_ios_rounded,
                              color: Colors.black), // Cor preta
                          onPressed: () {
                            Navigator.pop(
                                context); // Volta para a tela anterior
                          },
                        ),

                        const Spacer(), // Para empurrar os outros elementos para a direita
                        // Ícone de engrenagem
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(Icons.settings,
                              color: Colors.black), // Cor preta
                          onPressed: () {
                            // Chama o diálogo de configurações
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const ConfigDialog(); // Chama o diálogo de configurações
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // Exibição das imagens com navegação por arrasto
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

                            // Lógica de animação de escala e opacidade com base no índice da página
                            if (_pageController.position.haveDimensions) {
                              double page = _pageController.page ?? 0.0;
                              scale = (1 - (index - page).abs())
                                  .clamp(0.85, 1.0); // Escala das imagens
                              opacity = (1 - (index - page).abs())
                                  .clamp(0.0, 1.0); // Opacidade das imagens
                            }

                            return Transform.scale(
                              scale: scale,
                              child: Opacity(
                                opacity: opacity,
                                child: Image.asset(
                                  tirinha[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Indicadores de pontos (dots)
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
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
                                ? Colors.black // Cor do ponto ativo
                                : Colors.grey, // Cor dos pontos inativos
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Botão para navegar para a página anterior
              Positioned(
                bottom: 50.h,
                left: 20.w,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      size: 48, color: Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () {
                    _navigateToPage(currentIndex - 1);
                  },
                ),
              ),
              // Botão para navegar para a próxima página
              Positioned(
                bottom: 50.h,
                right: 20.w,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded,
                      size: 48, color: Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () {
                    _navigateToPage(currentIndex + 1);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
