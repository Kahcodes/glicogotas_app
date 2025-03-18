import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'configuracoes.dart'; // Importando a página de configurações

class JogosPage extends StatelessWidget {
  const JogosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fundo branco
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              // Botões flutuantes e título
              Positioned(
                top: 40.h, // Espaçamento do topo
                left: 16.w, // Espaçamento da lateral esquerda
                right: 16.w, // Espaçamento da lateral direita
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão Home
                    IconButton(
                      iconSize: 32.sp,
                      icon: const Icon(
                        Icons.home_rounded,
                        color: Color(0xFFFF4081), // Cor FF4081
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Volta para a página anterior
                      },
                    ),
                    // Título da Página
                    Text(
                      'Jogos',
                      style: GoogleFonts.chewy(
                        fontSize: 24.sp,
                        color: const Color(0xFFFF4081), // Cor FF4081
                      ),
                    ),
                    // Botão Configurações
                    IconButton(
                      iconSize: 32.sp,
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFFFF4081), // Cor FF4081
                        size: 32,
                      ),
                      onPressed: () {
                        // Exibe o diálogo de configurações como modal transparente
                        showDialog(
                          context: context,
                         barrierColor: Colors.black.withAlpha((0.5 * 255).toInt()),// Fundo semitransparente
                          builder: (BuildContext context) {
                            return const ConfigDialog(); // Chama o diálogo de configurações
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 0.08.sh,
                left: 20.w,
                right: 20.w,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ah não, você chegou antes da surpresa ficar pronta! 🎉\n Logo, logo, teremos algo incrível aqui só para você!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.chewy(
                          fontSize: 14.sp,
                          color: const Color(0xFF37ABDC), // Cor FF4081
                        ),
                      ),
                      SizedBox(
                        height: 20.h, // Espaçamento entre o texto e a imagem
                      ),
                      SvgPicture.asset(
                        "assets/images/error.svg", // Caminho correto da imagem SVG
                        width: 450.w, // Tamanho da imagem
                        height: 450.h, // Tamanho da imagem
                        fit: BoxFit.cover, // Ajuste da imagem
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
