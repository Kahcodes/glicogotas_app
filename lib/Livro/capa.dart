import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:glicogotas_app/Livro/pagina1.dart'; // Certifique-se de que esse caminho está correto

class CapaPage extends StatelessWidget {
  const CapaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF265F95), // Fundo azul
      body: SafeArea(
        child: Column(
          children: [
            // Parte superior da tela (seta e configurações)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      // Ação para abrir configurações
                    },
                  ),
                ],
              ),
            ),

            // Espaçamento entre a parte superior e o conteúdo principal
            const SizedBox(height: 40),

            // Stack para centralizar o conteúdo
            Expanded(
              child: Stack(
                children: [
                  // Centralizando o texto e movendo um pouco para cima
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 100), // Ajustando o topo
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Texto "GLICOGOTAS" em arco
                          CustomPaint(
                            painter: ArcTextPainter(),
                            child: Container(height: 80),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'DESCOMPLICANDO',
                            style: GoogleFonts.chewy(
                                fontSize: 36, color: Colors.yellow),
                          ),
                          Text(
                            'o Diabetes',
                            style: GoogleFonts.chewy(
                                fontSize: 36, color: Colors.yellow),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Posicionando a Talita
                  // Personagem Talita no canto inferior esquerdo, com tamanho maior
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/images/talita_capa.png',
                      height: 290, // Aumentado para 250 para ocupar mais espaço
                      fit: BoxFit.cover,
                    ),
                  ),

// Pâncreas no canto inferior direito, com tamanho maior
                  Positioned(
                    bottom: 0,
                    right: 20,
                    child: Image.asset(
                      'assets/images/pancreas.png',
                      height: 180, // Aumentado para 220 para ocupar mais espaço
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // Parte inferior da tela com botões
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60, // Largura equivalente ao botão de voltar
                    ),
                    // Botão "som" centralizado
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/btn-som-azul.svg',
                        width: 60,
                      ),
                      onPressed: () {
                        // Ação do botão som
                      },
                    ),

                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/btn-avancar-azul.svg',
                        width: 60,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Pagina1Page()),
                        ); // Ação do botão voltar
                      },
                    ),

                    // Botão invisível para ocupar o espaço à direita
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CustomPainter para o texto em arco
class ArcTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final textStyle = GoogleFonts.chewy(
      fontSize: 50,
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    );

    const text = "GLICOGOTAS";
    final radius = size.width / 4;
    final centerX = size.width / 2;
    final centerY = size.height / 1.2;

    double startAngle = -pi / 2 - (160 * pi / 180) / 2;
    const totalAngle = 160 * pi / 180;
    const anglePerLetter = totalAngle / (text.length - 1);

    for (int i = 0; i < text.length; i++) {
      final angle = startAngle + (i * anglePerLetter);

      final offset = Offset(
        centerX + radius * cos(angle),
        centerY + radius * sin(angle),
      );

      textPainter.text = TextSpan(text: text[i], style: textStyle);
      textPainter.layout();

      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate(angle + pi / 2);
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
