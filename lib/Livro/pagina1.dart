import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/home.dart'; // Assumindo que o caminho da tela inicial seja esse

class Pagina1Page extends StatelessWidget {
  const Pagina1Page({super.key});

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
              'assets/images/fundopaglivro.svg', // Ajuste o caminho da imagem se necessário
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

          // Botões de navegação
          Positioned(
            bottom: 22,
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
                      builder: (context) =>
                          const TelaHome()), // Voltar para a tela inicial
                );
              },
            ),
          ),

          // Centralizando o botão do meio usando Align
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/btn-som-azul.svg',
                  width: 65,
                ),
                onPressed: () {
                  // Ação do botão som, se necessário
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
                // Ação do botão avançar
                // Substitua com a próxima tela, caso necessário
              },
            ),
          ),
        ],
      ),
    );
  }
}
