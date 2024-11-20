import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/bobo.dart';
import 'package:glicogotas_app/Personagens/lita.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonagemReiPage extends StatelessWidget {
  const PersonagemReiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: Stack(
        children: [
          // Fundo com as listras
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundo-rei.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Botão de voltar no topo esquerdo
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.home_rounded,
                color: Color.fromARGB(255, 0, 132, 255),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaHome()),
                );
              },
            ),
          ),

          // Botão de configurações no topo direito
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 0, 132, 255),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ConfigDialog(); // Chama o diálogo de configurações
                  },
                );
              },
            ),
          ),

          // Nome do personagem (Lita) centralizado
          Positioned(
            top: size.height * 0.15,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center, // Alinha os textos exatamente
              children: [
                // Texto branco (borda)
                Text(
                  'Rei da Hiper',
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.13,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 8
                      ..color = const Color(0xFFFFFEFF), // Cor da borda branca
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.25), // Sombra suave
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
                // Texto rosa
                Text(
                  'Rei da Hiper',
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.13,
                    color: const Color(0xFFEF291D), // Cor rosa
                  ),
                ),
              ],
            ),
          ),

          // A bola do personagem no fundo
          Positioned(
            top: size.height * 0.28,
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/eclipse-rei.svg',
                height: size.height * 0.36, // Aumentei ligeiramente a bola
              ),
            ),
          ),

          // Personagem sobreposta à bola
          Positioned(
            top: size.height * 0.22,
            left: 0,
            right: -10,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/rei-da-hiper.svg',
                height: size.height * 0.50,
              ),
            ),
          ),

          // Descrição do personagem
          Positioned(
            bottom: size.height * 0.20,
            left: 20,
            right: 20,
            child: Stack(
              alignment: Alignment
                  .center, // Alinhamento central para as camadas de texto
              children: [
                // Texto branco (borda)
                Text(
                  'Um vilão que faz o açúcar subir com sua coroa vermelha e sintomas poderosos!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.06,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 8
                      ..color = const Color(0xFFFFFEFF), // Cor da borda branca
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.25), // Sombra suave
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
                // Texto rosa
                Text(
                  'Um vilão que faz o açúcar subir com sua coroa vermelha e sintomas poderosos!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.06,
                    color: const Color(0xFFEF291D), // Cor rosa
                  ),
                ),
              ],
            ),
          ),

          // Botões de navegação e som
          Positioned(
            bottom:
                22, // Ajuste a altura aqui para aumentar a posição dos botões
            left: 20,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/images/btn-voltar-azul.svg',
                width: 65,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonagemLitaPage()),
                ); // Ação do botão voltar
              },
            ),
          ),

          // Centralizando o botão do meio usando Align
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 22), // Ajuste a altura aqui também
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/btn-som-azul.svg',
                  width: 65,
                ),
                onPressed: () {
                  // Ação do botão som
                },
              ),
            ),
          ),

          Positioned(
            bottom: 22, // Ajuste a altura aqui também para o botão da direita
            right: 20,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/images/btn-avancar-azul.svg',
                width: 65,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonagemBoboPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
