import 'package:flutter/material.dart';
import 'package:glicogotas_app/Livro/pagina1.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CapaPage extends StatefulWidget {
  const CapaPage({super.key});

  @override
  State<CapaPage> createState() => _CapaPageState();
}

class _CapaPageState extends State<CapaPage> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  // Função para reproduzir o áudio
  Future<void> _saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_page', page);
  }

  // Função para reproduzir o áudio
  @override
  void initState() {
    super.initState();
    _saveCurrentPage(2); // Salva o número da página atual
    _audioManager.play('audio/titulo.mp3', context); // Reproduz o áudio
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioManager.stop(); // Para o áudio ao sair da página
    _audioManager.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioManager.stop(); // Para o áudio ao ir para a próxima página
  }

  @override
  void didPopNext() {
    _audioManager.play(
        'audio/titulo.mp3', context); // Reinicia o áudio ao voltar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF265F95),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Ícone Home
                      IconButton(
                        iconSize: 30,
                        icon:
                            const Icon(Icons.home_rounded, color: Colors.white),
                        onPressed: () {
                          _audioManager
                              .stop(); // Parar o áudio antes de ir para a home
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TelaHome()),
                          );
                        },
                      ),
                      // Ícone Configurações
                      IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const ConfigDialog();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomPaint(
                                painter: ArcTextPainter(),
                                child: Container(height: 80),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'DESCOMPLICANDO',
                                style: GoogleFonts.chewy(
                                    fontSize: 36, color: Colors.yellow),
                              ),
                              Text(
                                'o Diabetes',
                                style: GoogleFonts.chewy(
                                    fontSize: 36, color: Colors.yellow),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Image.asset("assets/images/talita_capa.png",
                            height: 290, fit: BoxFit.cover),
                      ),

                      // Novo botão de avançar
                      Positioned(
                        bottom: 50, // Ajuste para posicionar perto da imagem
                        right: 30, // Lateral direita
                        child: GestureDetector(
                          onTap: () {
                            _audioManager
                                .stop(); // Para o áudio ao ir para a próxima página
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Pagina1Page()),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/images/btn-avancar-branco.svg', // Novo botão
                            height: 65, // Tamanho do botão
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Classe para desenhar o texto em arco
class ArcTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final textStyle = GoogleFonts.chewy(
      fontSize: 50,
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    );

    const text = "GLICOGOTAS";
    final radius = size.width / 4;
    final centerX = size.width / 2;
    final centerY = size.height / 1.2;

    double startAngle = -pi / 2 - (160 * pi / 180) / 2;
    const totalAngle = 160 * pi / 180;
    const anglePerLetter = totalAngle / (text.length - 1);

    for (int i = 0; i < text.length; i++) {
      final angle = startAngle + (i * anglePerLetter);
      final offset = Offset(
        centerX + radius * cos(angle),
        centerY + radius * sin(angle),
      );

      textPainter.text = TextSpan(text: text[i], style: textStyle);
      textPainter.layout();

      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate(angle + pi / 2);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
