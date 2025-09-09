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
    return LayoutBuilder(
      builder: (context, constraints) {
        // define se é tablet ou celular
        bool isTablet = constraints.maxWidth > 600;

        double titleSize = isTablet ? 32 : 26;
        double bodySize = isTablet ? 22 : 18;
        double devNameSize = isTablet ? 28 : 22;
        double coordNameSize = isTablet ? 22 : 18;
        double colabNameSize = isTablet ? 18 : 16;

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
              style: GoogleFonts.chewy(fontSize: titleSize),
            ),
            backgroundColor: const Color(0xFFA27348),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFA27348),
                  Color(0xFFE7D1AE),
                  Color(0xFFA27348)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: 700), // limita largura no tablet
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Foto
                      CircleAvatar(
                        radius: isTablet ? 90 : 70,
                        backgroundImage:
                            const AssetImage('assets/images/jo&kah.png'),
                        backgroundColor: const Color(0xFFA27348),
                      ),
                      const SizedBox(height: 20),

                      // Saudação
                      Text(
                        'Olá! 🌟',
                        style: GoogleFonts.chewy(
                          fontSize: isTablet ? 34 : 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Texto introdutório
                      Text(
                        'Somos Jordana e Karyne, desenvolvedoras deste aplicativo e estudantes do IFB. '
                        'Ele foi inspirado em um livro de feltro interativo sobre diabetes tipo 1, lá no IFRJ.',
                        style: GoogleFonts.chewy(
                          fontSize: bodySize,
                          color: Colors.white,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nosso objetivo é ajudar as crianças a entenderem o diabetes de uma forma divertida e educativa. '
                        'Queremos tornar o aprendizado mais leve e acessível, criando um mundo de empatia e carinho para todos. 💖',
                        style: GoogleFonts.chewy(
                          fontSize: bodySize,
                          color: Colors.white,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // Ícones das autoras
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialLink(
                              "Jordana", "https://instagram.com/jordanarosab"),
                          const SizedBox(width: 60),
                          _socialLink(
                              "Karyne", "https://instagram.com/kahlory__"),
                        ],
                      ),

                      const SizedBox(height: 40),
                      Divider(color: Colors.white70, thickness: 1),
                      const SizedBox(height: 32),

                      // Créditos
                      _sectionTitle("Créditos", isTablet),

                      const SizedBox(height: 20),

                      _creditLine(
                        "Jordana e Karyne",
                        "Desenvolvedoras do aplicativo",
                        fontSizeName: devNameSize,
                        fontSizeRole: bodySize,
                      ),
                      const SizedBox(height: 16),
                      _creditLine(
                        "Tiago Segato e Sharon Landgraf",
                        "Coordenação técnica",
                        fontSizeName: coordNameSize,
                        fontSizeRole: bodySize - 2,
                      ),
                      const SizedBox(height: 16),
                      _creditLine(
                        "Colaboradores",
                        "Talita Kellen, Fabrícia Viana Fonseca, Thalia Candido",
                        fontSizeName: colabNameSize,
                        fontSizeRole: colabNameSize - 2,
                      ),

                      const SizedBox(height: 40),
                      Divider(color: Colors.white70, thickness: 1),
                      const SizedBox(height: 32),

                      // Projeto oficial
                      _sectionTitle("Conheça o Projeto:", isTablet),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => _launchURL(
                            'https://www.instagram.com/glicogotas.ifrj/'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.instagram,
                                color: Colors.white, size: 30),
                            const SizedBox(width: 10),
                            Text(
                              "@glicogotas.ifrj",
                              style: GoogleFonts.chewy(
                                fontSize: bodySize,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 50),

                      // Rodapé
                      Text(
                        'Versão 1.0 | © 2024/2025 | Feito com 💕',
                        style: GoogleFonts.chewy(
                          fontSize: isTablet ? 18 : 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => _launchURL(
                            "https://creativecommons.org/licenses/by/3.0/deed.en_US"),
                        child: Text(
                          "Música: Carnival Is Coming - Alex-Productions\nLicença: CC BY 3.0",
                          style: GoogleFonts.chewy(
                            fontSize: isTablet ? 14 : 10,
                            color: Colors.white70,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Widget para títulos de seções
  Widget _sectionTitle(String text, bool isTablet) {
    return Text(
      text,
      style: GoogleFonts.chewy(
        fontSize: isTablet ? 26 : 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Widget para linhas de crédito (com tamanho customizável)
  Widget _creditLine(String name, String role,
      {double fontSizeName = 18, double fontSizeRole = 14}) {
    return Column(
      children: [
        Text(
          name,
          style: GoogleFonts.chewy(
            fontSize: fontSizeName,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          role,
          style: GoogleFonts.chewy(
            fontSize: fontSizeRole,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Widget para ícone + nome do Instagram
  Widget _socialLink(String name, String url) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.instagram,
              color: Colors.white, size: 36),
          onPressed: () => _launchURL(url),
          tooltip: "Instagram $name",
        ),
        Text(
          name,
          style: GoogleFonts.chewy(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
