import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/capa.dart';
import 'package:glicogotas_app/Livro/pagina2.dart';
import 'package:glicogotas_app/home.dart';

class Pagina1Page extends StatelessWidget {
  const Pagina1Page({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFfffcf3),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundopaglivro.svg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.home_rounded,
                color: Color(0xFF265F95),
              ),
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
              icon: const Icon(
                Icons.settings,
                color: Color(0xFF265F95),
              ),
              onPressed: () {},
            ),
          ),

          // Personagem Lita centralizada e maior
          Positioned(
            top: size.height * 0.25,
            right: size.width * 0.15,
            child: SvgPicture.asset(
              'assets/images/lita.svg', // Substitua pelo caminho correto do arquivo da imagem da Lita
              height: size.height * 0.6, // Aumentado para 40% da altura da tela
            ),
          ),

          // Balão de fala reposicionado e maior
          Positioned(
            top: size.height *
                0.05, // Descido um pouco mais para ficar mais próximo da Lita
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: SvgPicture.asset(
              'assets/images/balão-duplo.svg', // Caminho do SVG do balão duplo
              width: size.width * 1.2, // Aumentado para 120% da largura da tela
            ),
          ),

          // TabBar laranja com botão de avançar à direita
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(color: Color(0xFFFCB44E)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-voltar-laranja.svg',
                      width: 55,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CapaPage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-som-laranja.svg',
                      width: 55,
                    ),
                    onPressed: () {
                      // Ação do botão som
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-avancar-laranja.svg',
                      width: 55,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Pagina2Page()),
                      );
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
