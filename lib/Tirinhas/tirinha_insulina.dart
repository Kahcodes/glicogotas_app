import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/configuracoes.dart'; // Importando a tela de configurações

class TirinhaInsulina extends StatefulWidget {
  const TirinhaInsulina({super.key});

  @override
  TirinhaState createState() => TirinhaState();
}

class TirinhaState extends State<TirinhaInsulina> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com a imagem SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundo-hist.svg', // Caminho da imagem SVG
              fit: BoxFit.cover,
            ),
          ),
          // Elementos sobrepondo o fundo
          Column(
            children: [
              // Linha com o título e os ícones no topo da tela
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical:
                        40.0), // Ajuste no padding para afastar os elementos do topo
                child: Row(
                  children: [
                    // Ícone de seta de voltar
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          color: Colors.black), // Cor preta
                      onPressed: () {
                        Navigator.pop(context); // Volta para a tela anterior
                      },
                    ),

                    const Spacer(), // Para empurrar os outros elementos para a direita
                    // Ícone de engrenagem
                    IconButton(
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
              // Indicadores de pontos (dots) movidos para cima
              Positioned(
                top: 140, // Ajusta a posição para mover os dots para cima
                left: 0,
                right: 0,
                child: Row(
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
                            ? Colors.black // Cor do ponto ativo
                            : Colors.grey, // Cor dos pontos inativos
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Espaçamento abaixo
            ],
          ),
        ],
      ),
    );
  }
}
