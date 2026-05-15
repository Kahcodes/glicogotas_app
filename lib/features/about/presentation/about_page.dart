import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glicogotas_app/core/theme/app_text_styles.dart';
import 'package:glicogotas_app/core/ui/system_bars_style.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final titleSize = isTablet ? 32.0 : 26.0;
        final bodySize = isTablet ? 22.0 : 18.0;
        final devNameSize = isTablet ? 28.0 : 22.0;
        final coordNameSize = isTablet ? 22.0 : 18.0;
        final colabNameSize = isTablet ? 18.0 : 16.0;

        return SystemBarsStyle(
          statusBarColor: const Color(0xFFA27348),
          navigationBarColor: const Color(0xFFA27348),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Sobre Nós',
                style: AppTextStyles.chewy(fontSize: titleSize),
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
                    Color(0xFFA27348),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: isTablet ? 90 : 70,
                          backgroundImage:
                              const AssetImage('assets/images/jo&kah.png'),
                          backgroundColor: const Color(0xFFA27348),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Olá!',
                          style: AppTextStyles.chewy(
                            fontSize: isTablet ? 34 : 28,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Somos Jordana e Karyne, desenvolvedoras deste aplicativo e estudantes do IFB. '
                          'Ele foi inspirado em um livro de feltro interativo sobre diabetes tipo 1, lá no IFRJ.',
                          style: AppTextStyles.chewy(
                            fontSize: bodySize,
                            color: Colors.white,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nosso objetivo é ajudar as crianças a entenderem o diabetes de uma forma divertida e educativa. '
                          'Queremos tornar o aprendizado mais leve e acessível, criando um mundo de empatia e carinho para todos.',
                          style: AppTextStyles.chewy(
                            fontSize: bodySize,
                            color: Colors.white,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _SocialLink(
                              name: 'Jordana',
                              url: 'https://instagram.com/jordanarosab',
                              onLaunch: _launchUrl,
                            ),
                            const SizedBox(width: 60),
                            _SocialLink(
                              name: 'Karyne',
                              url: 'https://instagram.com/kahlory__',
                              onLaunch: _launchUrl,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        const Divider(color: Colors.white70),
                        const SizedBox(height: 32),
                        _SectionTitle('Créditos', isTablet: isTablet),
                        const SizedBox(height: 20),
                        _CreditLine(
                          name: 'Jordana e Karyne',
                          role: 'Desenvolvedoras do aplicativo',
                          fontSizeName: devNameSize,
                          fontSizeRole: bodySize,
                        ),
                        const SizedBox(height: 16),
                        _CreditLine(
                          name: 'Tiago Segato e Sharon Landgraf',
                          role: 'Coordenação técnica',
                          fontSizeName: coordNameSize,
                          fontSizeRole: bodySize - 2,
                        ),
                        const SizedBox(height: 16),
                        _CreditLine(
                          name: 'Colaboradores',
                          role:
                              'Talita Kellen, Fabrícia Viana Fonseca, Thalia Candido',
                          fontSizeName: colabNameSize,
                          fontSizeRole: colabNameSize - 2,
                        ),
                        const SizedBox(height: 40),
                        const Divider(color: Colors.white70),
                        const SizedBox(height: 32),
                        _SectionTitle(
                          'Conheça o Projeto:',
                          isTablet: isTablet,
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => _launchUrl(
                            'https://www.instagram.com/glicogotas/',
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '@glicogotas.ifrj',
                                style: AppTextStyles.chewy(
                                  fontSize: bodySize,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          'Versão 1.0 | 2024/2025',
                          style: AppTextStyles.chewy(
                            fontSize: isTablet ? 18 : 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => _launchUrl(
                            'https://creativecommons.org/licenses/by/3.0/deed.en_US',
                          ),
                          child: Text(
                            'Música: Carnival Is Coming - Alex-Productions\nLicença: CC BY 3.0',
                            style: AppTextStyles.chewy(
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
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {required this.isTablet});

  final String text;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.chewy(
        fontSize: isTablet ? 26 : 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _CreditLine extends StatelessWidget {
  const _CreditLine({
    required this.name,
    required this.role,
    required this.fontSizeName,
    required this.fontSizeRole,
  });

  final String name;
  final String role;
  final double fontSizeName;
  final double fontSizeRole;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: AppTextStyles.chewy(
            fontSize: fontSizeName,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          role,
          style: AppTextStyles.chewy(
            fontSize: fontSizeRole,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SocialLink extends StatelessWidget {
  const _SocialLink({
    required this.name,
    required this.url,
    required this.onLaunch,
  });

  final String name;
  final String url;
  final Future<void> Function(String url) onLaunch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.instagram,
            color: Colors.white,
            size: 36,
          ),
          onPressed: () => onLaunch(url),
          tooltip: 'Instagram $name',
        ),
        Text(
          name,
          style: AppTextStyles.chewy(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
