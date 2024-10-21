import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonagensPage extends StatelessWidget {
  const PersonagensPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém as dimensões da tela para ajustar o layout de maneira responsiva
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF23A6F0), // Cor da barra de app
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Ação para abrir configurações
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // O fundo azul
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/fundo-azul.svg',
                fit: BoxFit.cover,
              ),
            ),

            // Conteúdo centralizado
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Título "Bem-Vindos"
                  Text(
                    'Bem-Vindos',
                    style: GoogleFonts.chewy(
                      color: const Color(0xFFF4719C),
                      fontSize: size.width * 0.1, // Fonte responsiva
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16), // Espaço entre o título e a logo

                  // Logo
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/tela-inicial-perso.png', // Caminho para a logo
                      height: size.height * 0.4, // Aumentar altura da imagem
                    ),
                  ),

                  const SizedBox(height: 16), // Espaço entre a logo e o texto

                  // Texto abaixo da imagem
                  Text(
                    'À Turminha do Glicogotas!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.chewy(
                      color: const Color(0xFFF4719C),
                      fontSize: size.width * 0.08, // Fonte responsiva
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20), // Espaço entre o texto e o botão

                  // Botão de avançar
                  IconButton(
                    icon: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/btn-avancar.svg',
                        width: 55,
                      ),
                    ),
                    onPressed: () {
                      // Ação do botão próximo (ainda não definido)
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
