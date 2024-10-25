import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/lita.dart';
import 'package:glicogotas_app/home.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonagensPage extends StatelessWidget {
  const PersonagensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // O fundo azul cobrindo toda a tela
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundo-azul.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Botão de configurações no topo direito
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.home_rounded, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaHome()),
                );
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ),

          // Título "Bem-Vindos" com contorno branco e sombra
          Positioned(
            top: size.height * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                children: [
                  // Contorno branco
                  Text(
                    'Bem-Vindos',
                    style: GoogleFonts.chewy(
                      fontSize: size.width * 0.13, // Fonte maior
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.25), // Sombra suave
                          offset: const Offset(3.0, 3.0), // Ajuste de sombra
                          blurRadius: 5.0,
                        ),
                      ],
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 8
                        ..color =
                            const Color(0xFFFFFEFF), // Cor do contorno (branca)
                    ),
                  ),
                  // Preenchimento rosa e sombra
                  Text(
                    'Bem-Vindos',
                    style: GoogleFonts.chewy(
                      color: const Color(
                          0xFFF4719C), // Cor do preenchimento (rosa)
                      fontSize: size.width * 0.13, // Fonte maior
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // A imagem central ajustada para ficar parcialmente fora da tela
          Positioned(
            top: size.height * 0.22, // Alinhamento vertical
            left: 0, // A imagem começará da borda esquerda
            right: 0, // A imagem terminará na borda direita
            child: SvgPicture.asset(
              'assets/images/tela-inicial-perso.svg', // Caminho da imagem
              width: size.width, // Largura da imagem igual à largura da tela
              fit: BoxFit.cover, // Ajuste da imagem sem distorcer
            ),
          ),

          // Espaço extra com ajuste de posicionamento
          // Texto "A Turminha do Glicogotas!" centralizado, com contorno e sombra
          Positioned(
            bottom: size.height * 0.15,
            left: size.width * 0.15,
            right: size.width * 0.15,
            child: Transform.rotate(
              angle: -0.03,
              child: FittedBox(
                // Ajuste de tamanho automático
                fit: BoxFit.scaleDown, // Reduz o texto para caber na área
                child: Stack(
                  children: [
                    // Contorno branco
                    Text(
                      'A Turminha do Glicogotas!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        fontSize: size.width * 0.16,
                        fontWeight: FontWeight.w400,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(3.0, 3.0),
                            blurRadius: 5.0,
                          ),
                        ],
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color = const Color(0xFFFFFEFF),
                      ),
                    ),
                    // Preenchimento rosa e sombra
                    Text(
                      'A Turminha do Glicogotas!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        color: const Color(0xFFF4719C),
                        fontSize: size.width * 0.16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 22), // Ajuste a altura aqui também
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/btn-som-branco.svg',
                  width: 65,
                ),
                onPressed: () {
                  // Ação do botão som
                },
              ),
            ),
          ),

          // Botão de avançar no canto inferior direito
          Positioned(
            bottom: 22,
            right: 20,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/images/btn-avancar-branco.svg',
                width: 65,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonagemLitaPage()),
                ); // Ação do botão próximo
              },
            ),
          ),
        ],
      ),
    );
  }
}
