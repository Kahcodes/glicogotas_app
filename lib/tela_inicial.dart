import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'tela_opcoes.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // O fundo com as ondinhas
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/decoracao.svg', // O caminho para o SVG exportado
                fit: BoxFit.cover,
              ),
            ),

            // Logo e conteúdo centralizado
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/glicogotas_logo.png', // Caminho para o logo
                      height: 407,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 29,
                    child: Text(
                      'Desvendando o Diabetes',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sansitaSwashed(
                        color: const Color(0xFF265F95),
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 38), // Espaçamento entre o texto e o botão

                  // Botão de iniciar
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TelaOpcoes()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFF00D287), // Cor de fundo do botão (verde)
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(40), // Borda arredondada
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8), // Padding do botão
                    ),
                    child: SizedBox(
                      width: 153,
                      height: 32,
                      child: Center(
                        child: Text(
                          'INICIAR',
                          style: GoogleFonts.podkova(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
