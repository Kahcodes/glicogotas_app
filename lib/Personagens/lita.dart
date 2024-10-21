import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonagensPage extends StatelessWidget {
  const PersonagensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // O fundo lita
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/fundo-lita.svg',
                fit: BoxFit.cover,
              ),
            ),

            // Ícones de voltar e configurações no topo
            Positioned(
              top: 40,
              left: 16,
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back_ios, color: Color(0xFF265F95)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Color(0xFF265F95)),
                onPressed: () {},
              ),
            ),

            // Conteúdo da tela
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Título com sombra
                  Text(
                    'Lita',
                    style: GoogleFonts.chewy(
                      color: const Color(0xFFF4719C),
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      shadows: [
                        Shadow(
                          color: Colors.white, // Cor da sombra
                          offset: Offset(2.0, 2.0), // Deslocamento da sombra
                          blurRadius: 4.0, // Raio de desfoque da sombra
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16), // Espaço entre título e logo

                  // Ícone central
                  SizedBox(
                    width: 131,
                    height: 282,
                    child: ClipRect(
                      child: Image.asset(
                        'assets/images/talita_icon.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 16), // Espaçamento entre a imagem e o texto

                  // Texto abaixo da imagem
                  SizedBox(
                    width: 300,
                    child: Text(
                      'Ela é uma super-heroína que enfrenta o DM1 em grandes aventuras!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.chewy(
                        color: const Color(0xFF265F95),
                        fontSize: 15.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 40), // Espaçamento entre o texto e os botões
                ],
              ),
            ),

            // Parte inferior da tela
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors
                      .transparent, // Mantém a parte inferior transparente
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/btn-voltar.svg',
                        width: 55,
                      ),
                      onPressed: () {
                        // Ação do botão anterior
                      },
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
