import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'configuracoes.dart'; // Importando a página de configurações

class JogosPage extends StatelessWidget {
  const JogosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // Fundo branco
      body: Stack(
        children: [
          // Botões flutuantes e título
          Positioned(
            top: 40, // Espaçamento do topo
            left: 16, // Espaçamento da lateral esquerda
            right: 16, // Espaçamento da lateral direita
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão Home
                IconButton(
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
                    fontSize: 24,
                    color: const Color(0xFFFF4081), // Cor FF4081
                  ),
                ),
                // Botão Configurações
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Color(0xFFFF4081), // Cor FF4081
                    size: 32,
                  ),
                  onPressed: () {
                    // Exibe o diálogo de configurações como modal transparente
                    showDialog(
                      context: context,
                      barrierColor: Colors.black
                          .withOpacity(0.5), // Fundo semitransparente
                      builder: (BuildContext context) {
                        return const ConfigDialog(); // Chama o diálogo de configurações
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          // Conteúdo principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ah não, você chegou antes da surpresa ficar pronta! 🎉\nLogo, logo, teremos algo incrível aqui só para você!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    fontSize: 16,
                    color: const Color(0xFF37ABDC), // Cor FF4081
                  ),
                ),
                const SizedBox(
                  height: 20, // Espaçamento entre o texto e a imagem
                ),
                SvgPicture.asset(
                  "assets/images/error.svg", // Caminho correto da imagem SVG
                  width: 450, // Tamanho da imagem
                  height: 450, // Tamanho da imagem
                  fit: BoxFit.cover, // Ajuste da imagem
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
