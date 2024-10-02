import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaOpcoes extends StatelessWidget {
  const TelaOpcoes({super.key});

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
                'assets/images/decoracao.svg',
                fit: BoxFit.cover,
              ),
            ),

            // Ícones de voltar e configurações no topo
            Positioned(
              top: 40, // Ajuste a posição vertical conforme necessário
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF265F95)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              top: 40, // Ajuste a posição vertical conforme necessário
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Color(0xFF265F95)),
                onPressed: () {},
              ),
            ),

            // Conteúdo da tela centralizado
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Ícone central
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/talita_icon.png',
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Como vamos ',
                          style: GoogleFonts.sansitaSwashed(
                            fontSize: 24,
                            color: Colors.blue,
                          ),
                        ),
                        TextSpan(
                          text: 'aprender hoje?',
                          style: GoogleFonts.sansitaSwashed(
                            fontSize: 24,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Botões de opções
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Cor do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: const SizedBox(
                      width: 153,
                      height: 32,
                      child: Center(
                        child: Text(
                          'LIVRO',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D287), // Cor do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: const SizedBox(
                      width: 153,
                      height: 32,
                      child: Center(
                        child: Text(
                          'HISTÓRIA',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent, // Cor do botão
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: const SizedBox(
                      width: 153,
                      height: 32,
                      child: Center(
                        child: Text(
                          'JOGOS',
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
