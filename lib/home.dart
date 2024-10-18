import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/glicogotas.dart';
import 'package:glicogotas_app/Livro/capa.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({super.key});

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
                  // Row para alinhar a imagem e o texto lado a lado
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          width: 20), // Espaçamento entre a imagem e o texto
                      // Texto lado a lado
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Alinhamento à esquerda
                        children: [
                          Text(
                            'Como vamos',
                            style: GoogleFonts.sansitaSwashed(
                              color: const Color(0xFF37ABDC),
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'aprender',
                                  style: GoogleFonts.sansitaSwashed(
                                    color: const Color(0xFFF4719C),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: ' hoje?',
                                  style: GoogleFonts.sansitaSwashed(
                                    color: const Color(0xFF37ABDC),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 40), // Espaçamento entre o texto e os botões

                  // Botões de opções, um abaixo do outro
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PersonagensPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D287),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: SizedBox(
                      width: 154,
                      height: 32,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              "assets/images/person.svg",
                              fit: BoxFit.cover,
                              height: 23,
                              width: 23,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'PERSONAGENS',
                              style: GoogleFonts.podkova(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LivroPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: SizedBox(
                      width: 153,
                      height: 32,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              "assets/images/livro.svg",
                              fit: BoxFit.cover,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'LIVRO',
                              style: GoogleFonts.podkova(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFCB44E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: SizedBox(
                      width: 153,
                      height: 32,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              "assets/images/historia.svg",
                              fit: BoxFit.cover,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'HISTÓRIA',
                              style: GoogleFonts.podkova(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Espaçamento entre os botões

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: SizedBox(
                      width: 153,
                      height: 32,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              "assets/images/jogos.svg",
                              fit: BoxFit.cover,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'JOGOS',
                              style: GoogleFonts.podkova(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
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
