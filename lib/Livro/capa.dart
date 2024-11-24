import 'package:flutter/material.dart';
import 'package:glicogotas_app/Livro/pagina1.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class CapaPage extends StatefulWidget {
  const CapaPage({super.key});

  @override
  State<CapaPage> createState() => _CapaPageState();
}

class _CapaPageState extends State<CapaPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAudio(); // Toca o áudio ao abrir a página
  }

  @override
  void dispose() {
    _audioPlayer.stop(); // Para o áudio ao sair da página
    _audioPlayer.dispose(); // Libera os recursos do áudio ao fechar a página
    super.dispose();
  }

  Future<void> _playAudio() async {
    await _audioPlayer.play(AssetSource('audio/titulo.mp3'));
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
                          _audioPlayer
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
                      Positioned(
                        bottom: 0,
                        right: 20,
                        child: Image.asset("assets/images/pancreas.png",
                            height: 180, fit: BoxFit.cover),
                      ),
                      // Botão invisível para avançar para a próxima página
                      Positioned(
                        bottom: 120, // Ajuste para posicionar acima da imagem
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _audioPlayer
                                .stop(); // Para o áudio ao ir para a próxima página
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Pagina1Page()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 400, // Aumentei a altura do botão invisível
                            color:
                                Colors.transparent, // Invisível, mas funcional
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
