import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart'; // Importa o pacote google_fonts

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // Adicionando o ícone de voltar
          icon: const Icon(Icons.arrow_back_ios), // Ícone de voltar
          onPressed: () {
            Navigator.pop(context); // Voltar para a tela anterior
          },
        ),
        title: Text(
          'Sobre Nós',
          style: GoogleFonts.chewy(
            // Usando Chewy com Google Fonts
            fontSize: 28,
          ),
        ),
        backgroundColor:
            const Color(0xFFA27348), // Cor mais escura do gradiente
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFA27348), // Cor 1
              Color(0xFFE7D1AE), // Cor 2
              Color(0xFFA27348), // Cor 3
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage(
                    'assets/images/jo&kah.png'), // Imagem correta
                backgroundColor:
                    const Color(0xFFA27348), // Cor combinando com o gradiente
              ),
              const SizedBox(height: 16),
              Text(
                'Olá! 🌟',
                style: GoogleFonts.chewy(
                  // Usando Chewy com Google Fonts
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Somos Jordana e Karyne, desenvolvedoras deste aplicativo. Ele foi inspirado em um livro de feltro interativo sobre diabetes tipo 1, lá no IFRJ.',
                style: GoogleFonts.chewy(
                  // Usando Chewy com Google Fonts
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Nosso objetivo é ajudar as crianças a entenderem o diabetes de uma forma divertida e educativa. Queremos tornar o aprendizado mais leve e acessível, criando um mundo de empatia e carinho para todos. 💖',
                style: GoogleFonts.chewy(
                  // Usando Chewy com Google Fonts
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () =>
                        _launchURL('https://instagram.com/jordanarosab'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Jordana',
                          style: GoogleFonts.chewy(
                            // Usando Chewy com Google Fonts
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _launchURL('https://instagram.com/kahlory__'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                          size: 32,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Karyne',
                          style: GoogleFonts.chewy(
                            // Usando Chewy com Google Fonts
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Versão 1.0 | © 2024/2025 | Feito com 💕',
                style: GoogleFonts.chewy(
                  // Usando Chewy com Google Fonts
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
