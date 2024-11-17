import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/pagina1.dart';
import 'package:glicogotas_app/Livro/pagina4.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';

class Pagina3Page extends StatefulWidget {
  const Pagina3Page({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Pagina3PageState createState() => _Pagina3PageState();
}

class _Pagina3PageState extends State<Pagina3Page> {
  @override
  void initState() {
    super.initState();

    // Definindo o tempo para 3 segundos antes de mudar de página
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              Pagina4Page(),
          transitionDuration: Duration.zero, // Remove a duração da transição
          reverseTransitionDuration:
              Duration.zero, // Remove a duração da transição reversa
        ),
      );
    });
  }

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

          Positioned(
            top: size.height *
                0.2, // Move para cima, para permitir que o SVG exceda o limite
            left: -size.width *
                0.1, // Move para a esquerda, para permitir que o SVG exceda o limite
            child: SvgPicture.asset(
              'assets/images/lita-pancreas.svg',
              width: size.width * 0.7, // 120% da largura da tela
              height: size.height * 0.6, // 120% da altura da tela
            ),
          ),

          // Balão de fala reposicionado
          Positioned(
            top: size.height * 0.15,
            left: size.width * 0.1,
            child: SvgPicture.asset(
              'assets/images/balão-page3.svg',
              width: size.width * 0.8, // Ajuste para caber melhor
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão "voltar" à esquerda
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-voltar-laranja.svg',
                      width: 60,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Pagina1Page()),
                      ); // Ação do botão voltar
                    },
                  ),

                  // Botão "som" centralizado
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/btn-som-laranja.svg',
                      width: 60,
                    ),
                    onPressed: () {
                      // Ação do botão som
                    },
                  ),

                  // Botão invisível para ocupar o espaço à direita
                  SizedBox(
                    width: 60, // Largura equivalente ao botão de voltar
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
