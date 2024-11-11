import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pagina4.dart'; // Importando a próxima página

class Pagina3Page extends StatelessWidget {
  const Pagina3Page({super.key});

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
                Icons.arrow_back_ios,
                color: Color(0xFF265F95),
              ),
              onPressed: () {
                Navigator.pop(context); // Navega para a página anterior
              },
            ),
          ),
          Positioned(
            top: size.height * 0.15,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  'Título da Página 3',
                  style: TextStyle(
                    fontSize: size.width * 0.13,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 8
                      ..color = const Color(0xFFFFFEFF),
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Título da Página 3',
                  style: TextStyle(
                    fontSize: size.width * 0.13,
                    color: const Color(0xFFF4719C),
                  ),
                ),
              ],
            ),
          ),
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
                      'assets/images/btn-avancar.svg',
                      width: 55,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const Pagina4Page(), // Navega para a próxima página
                        ),
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
