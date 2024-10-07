import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math'; // Para manipulação de ângulos

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

            // Textos centrais (título e subtítulo)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Texto "GLICOGOTAS" em arco
                  CustomPaint(
                    painter: ArcTextPainter(),
                    child: Container(
                      height: 100, // Altura que o arco vai ocupar
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'DESCOMPLICANDO',
                    style: GoogleFonts.chewy(
                      fontSize: 24,
                      color: Colors.yellow,
                    ),
                  ),
                  Text(
                    'o Diabetes',
                    style: GoogleFonts.chewy(
                      fontSize: 24,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Imagens centralizadas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/talita_capa.png',
                        height: 175,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/images/pancreas.png',
                        height: 134,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Parte inferior da tela (botões de navegação)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFFFFD700), // Cor de fundo amarela
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-voltar.svg',
                      width: 30,
                    ),
                    onPressed: () {
                      // Ação do botão anterior
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-som.svg',
                      width: 30,
                    ),
                    onPressed: () {
                      // Ação do botão música
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-ler.svg',
                      width: 30,
                    ),
                    onPressed: () {
                      // Ação do botão ler
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-avancar.svg',
                      width: 30,
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
      fontSize: 36,
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    );

    const text = "GLICOGOTAS";
    final radius = size.width / 2; // Raio do arco
    final centerX = size.width / 2; // Centro do arco no eixo X
    final centerY = size.height /
        3; // Centro do arco no eixo Y (ajuste para posicionamento)

    // Ângulo inicial para a primeira letra
    double startAngle = -pi / 2; // Inicia o arco curvado para cima

    // Ângulo que cada letra ocupará
    final anglePerLetter =
        pi / (text.length - 1); // Divide o arco igualmente entre as letras

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
