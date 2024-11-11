import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina3.dart';

class Pagina2Page extends StatelessWidget {
  const Pagina2Page({super.key});

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
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: size.height * 0.15,
            left: 0,
            right: 0,
            child: Text(
              'Título da Página 2',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.1,
                color: const Color(0xFFF4719C),
              ),
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
                      'assets/images/btn-voltar.svg',
                      width: 55,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
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
                      'assets/images/btn-som.svg',
                      width: 55,
                    ),
                    onPressed: () {
                      // Ação do botão som
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
                            builder: (context) => const Pagina3Page()),
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
