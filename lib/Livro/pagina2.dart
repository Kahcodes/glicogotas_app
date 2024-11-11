import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Pagina2Page extends StatelessWidget {
  const Pagina2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFfffcf3),
      body: Stack(
        children: [
          // Fundo com as listras
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundopaglivro.svg', // fundo e tals
              fit: BoxFit.cover,
            ),
          ),

          // Ícone de voltar no topo esquerdo
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF265F95),
              ),
              onPressed: () {
                Navigator.pop(context); // Voltar à página anterior
              },
            ),
          ),

          // Ícone de configurações no topo direito
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.settings,
                color: Color(0xFF265F95),
              ),
              onPressed: () {
                // Ação do botão de configurações
              },
            ),
          ),

          // Nome do personagem ou título centralizado
          Positioned(
            top: size.height * 0.15,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center, // Alinha os textos exatamente
              children: [
                // Texto branco (borda)
                Text(
                  'Título da Página 1', // Título da nova página
                  style: TextStyle(
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
                // Texto central
                Text(
                  'Título da Página 1',
                  style: TextStyle(
                    fontSize: size.width * 0.13,
                    color: const Color(0xFFF4719C), // Cor rosa
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(color: Color(0xFFFCB44E)),
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
                      'assets/images/btn-avancar.svg', // Usando o mesmo ícone para "avançar"
                      width: 55,
                    ),
                    onPressed: () {
                      // Ação do botão avançar (Página 2)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Pagina2Page()),
                      );
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-avancar.svg', // Usando o mesmo ícone de "avançar" para o "voltar"
                      width: 55,
                    ),
                    onPressed: () {
                      // Ação do botão voltar (retornar à página anterior)
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
