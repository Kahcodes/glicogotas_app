import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/configuracoes.dart'; // Importando a tela de configurações

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "História",
          style: GoogleFonts.chewy(),
        ),
        backgroundColor: const Color(0xFFFCB44E),
        actions: [
          // Ícone de engrenagem para acessar configurações
          IconButton(
            icon: const Icon(Icons.settings), // Ícone de engrenagem
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Fundo com a imagem SVG
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/fundo-hist.svg', // Caminho da imagem SVG
                fit: BoxFit.cover,
              ),
            ),
            // Conteúdo da tirinha
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centraliza verticalmente
              children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    tirinha.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index
                            ? const Color(0xFFA81A1A) // Cor do ponto ativo
                            : Colors.grey, // Cor dos pontos inativos
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espaçamento abaixo
              ],
            ),
          ],
        ),
      ),
    );
  }
}
