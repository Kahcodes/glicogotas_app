import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class LivroPage extends StatelessWidget {
  const LivroPage({super.key});

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
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Color(0xFFFFFFFF)),
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

            // Textos centrais
            Expanded(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Texto "GLICOGOTAS" em arco
                      CustomPaint(
                        painter: ArcTextPainter(),
                        child: Container(
                          height: 80,
                        ),
                      ),

                      const SizedBox(height: 10),
                      Text(
                        'DESCOMPLICANDO',
                        style: GoogleFonts.chewy(
                          fontSize: 36,
                          color: Colors.yellow,
                        ),
                      ),

                      Text(
                        'o Diabetes',
                        style: GoogleFonts.chewy(
                          fontSize: 36,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),

                  // Posicionando a Talita
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/images/talita_capa.png',
                      height: 175,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Posicionando o pâncreas no canto inferior direito
                  Positioned(
                    bottom: 0,
                    right: 20, // Adicionei um pequeno padding da direita
                    child: Image.asset(
                      'assets/images/pancreas.png',
                      height: 150, // Ajuste de altura do pâncreas
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // Parte inferior da tela
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-som.svg',
                      width: 55,
                    ),
                    onPressed: () {
                      // Ação do botão música
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-ler.svg',
                      width: 55,
                    ),
                    onPressed: () {
                      // Ação do botão ler
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-avancar.svg',
                      width: 55,
                    ),
                    onPressed: () {
                      // Ação do botão próximo
                    },
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

// CustomPainter para o texto em arco curvado para cima
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
    final radius = size.width / 4; // Raio do arco
    final centerX = size.width / 2; // Centro do arco no eixo X
    final centerY = size.height / 1.2; // Centro do arco no eixo Y

    // Ajuste para ângulo inicial: para começar a 80 graus antes do topo (160 graus / 2)
    double startAngle = -pi / 2 - (160 * pi / 180) / 2; // Ângulo inicial

    // Ângulo total que o texto vai ocupar: 160 graus (em radianos)
    const totalAngle = 160 * pi / 180; // Converte 160 graus para radianos

    // Calcula o ângulo que cada letra ocupará
    const anglePerLetter = totalAngle / (text.length - 1);

    for (int i = 0; i < text.length; i++) {
      // Calcula a posição de cada letra no arco
      final angle = startAngle + (i * anglePerLetter);

      // Coordenadas para cada letra no arco
      final offset = Offset(
        centerX + radius * cos(angle),
        centerY + radius * sin(angle),
      );

      // Definindo a rotação de cada letra para alinhá-las no arco
      textPainter.text = TextSpan(
        text: text[i],
        style: textStyle,
      );
      textPainter.layout();

      // Salva o estado do canvas para rotacionar cada letra individualmente
      canvas.save();

      // Move o canvas para a posição da letra
      canvas.translate(offset.dx, offset.dy);

      // Rotaciona a letra para que siga o arco corretamente
      canvas.rotate(
          angle + pi / 2); // Rotaciona as letras para alinhá-las no arco

      // Desenha a letra
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

      // Restaura o estado do canvas
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
