import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importando o flutter_svg

class JogosPage extends StatelessWidget {
  const JogosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'Jogos',
          style: GoogleFonts.chewy(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ah não, você chegou antes da surpresa ficar pronta! 🎉\nLogo, logo, teremos algo incrível aqui só para você!",
                textAlign: TextAlign.center,
                style: GoogleFonts.chewy(
                  fontSize: 16,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(
                  height: 20), // Espaçamento entre o texto e a imagem
              SvgPicture.asset(
                "assets/images/error.svg", // Caminho correto da imagem SVG
                width: 400, // Tamanho da imagem
                height: 400, // Tamanho da imagem
                fit: BoxFit.cover, // Ajuste da imagem
              ),
            ],
          ),
        ),
      ),
    );
  }
}
