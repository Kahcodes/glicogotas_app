import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  // Função para abrir links
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Sobre Nós',
          style: GoogleFonts.chewy(fontSize: 28),
        ),
        backgroundColor: const Color(0xFFA27348),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA27348), Color(0xFFE7D1AE), Color(0xFFA27348)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage('assets/images/jo&kah.png'),
                backgroundColor: Color(0xFFA27348),
              ),
              const SizedBox(height: 16),
              Text(
                'Olá! 🌟',
                style: GoogleFonts.chewy(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Somos Jordana e Karyne, desenvolvedoras deste aplicativo e estudantes do IFB. Ele foi inspirado em um livro de feltro interativo sobre diabetes tipo 1, lá no IFRJ.',
                style: GoogleFonts.chewy(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Nosso objetivo é ajudar as crianças a entenderem o diabetes de uma forma divertida e educativa. Queremos tornar o aprendizado mais leve e acessível, criando um mundo de empatia e carinho para todos. 💖',
                style: GoogleFonts.chewy(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Ícones de Instagram com nomes (autoras)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.instagram,
                            color: Colors.white, size: 32),
                        onPressed: () =>
                            _launchURL('https://instagram.com/jordanarosab'),
                        tooltip: "Instagram Jordana",
                      ),
                      Text(
                        "Jordana",
                        style: GoogleFonts.chewy(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.instagram,
                            color: Colors.white, size: 32),
                        onPressed: () =>
                            _launchURL('https://instagram.com/kahlory__'),
                        tooltip: "Instagram Karyne",
                      ),
                      Text(
                        "Karyne",
                        style: GoogleFonts.chewy(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(),

              Divider(color: Colors.white70),

              const SizedBox(height: 16),

              // Link do projeto antes da versão
              Column(
                children: [
                  Text(
                    "Conheça o Projeto:",
                    style: GoogleFonts.chewy(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _launchURL(
                        'https://www.instagram.com/glicogotas.ifrj/'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.instagram,
                            color: Colors.white, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          "@glicogotas.ifrj",
                          style: GoogleFonts.chewy(
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

              const SizedBox(height: 24),

              Text(
                'Versão 1.0 | © 2024/2025 | Feito com 💕',
                style: GoogleFonts.chewy(
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: () => _launchURL(
                    "https://creativecommons.org/licenses/by/3.0/deed.en_US"),
                child: Text(
                  "Música: Carnival Is Coming - Alex-Productions\nLicença: CC BY 3.0",
                  style: GoogleFonts.chewy(
                    fontSize: 10,
                    color: Colors.white70,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
