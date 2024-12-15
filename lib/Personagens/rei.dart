import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/bobo.dart';
import 'package:glicogotas_app/Personagens/lita.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart'; // Importando para controlar o áudio
import 'package:glicogotas_app/main.dart'; // Certifique-se de que routeObserver está importado

class PersonagemReiPage extends StatefulWidget {
  const PersonagemReiPage({super.key});

  @override
  PersonagemReiPageState createState() => PersonagemReiPageState();
}

class PersonagemReiPageState extends State<PersonagemReiPage> with RouteAware {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Método para tocar o áudio
  Future<void> _playAudio() async {
    await _audioPlayer.stop(); // Garante que o áudio anterior seja parado
    await _audioPlayer.play(AssetSource('audio/audioPersonagens/hiper.mp3'));
  }

  @override
  void initState() {
    super.initState();
    _playAudio(); // Toca o áudio ao entrar na página
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioPlayer.stop(); // Para o áudio ao sair da página
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioPlayer.stop(); // Para o áudio ao navegar para outra página
  }

  @override
  void didPopNext() {
    _playAudio(); // Reinicia o áudio ao voltar para esta página
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FF),
      body: Stack(
        children: [
          // Fundo com as listras
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundo-rei.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Botão de voltar no topo esquerdo
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.home_rounded,
                color: Color.fromARGB(255, 0, 132, 255),
              ),
              onPressed: () {
                _audioPlayer.stop(); // Para o áudio ao ir para a tela inicial
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaHome()),
                );
              },
            ),
          ),

          // Botão de configurações no topo direito
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.settings,
                color: Color.fromARGB(255, 0, 132, 255),
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

          // Nome do personagem (Rei da Hiper) centralizado
          Positioned(
            top: size.height * 0.15,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center, // Alinha os textos exatamente
              children: [
                // Texto branco (borda)
                Text(
                  'Rei da Hiper',
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.13,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 8
                      ..color = const Color(0xFFFFFEFF), // Cor da borda branca
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.25), // Sombra suave
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
                // Texto vermelho
                Text(
                  'Rei da Hiper',
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.13,
                    color: const Color(0xFFEF291D), // Cor vermelha
                  ),
                ),
              ],
            ),
          ),

          // A bola do personagem no fundo
          Positioned(
            top: size.height * 0.28,
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/eclipse-rei.svg',
                height: size.height * 0.36, // Aumentei ligeiramente a bola
              ),
            ),
          ),

          // Personagem sobreposta à bola
          Positioned(
            top: size.height * 0.22,
            left: 0,
            right: -10,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/rei-da-hiper.svg',
                height: size.height * 0.50,
              ),
            ),
          ),

          // Descrição do personagem
          Positioned(
            bottom: size.height * 0.20,
            left: 20,
            right: 20,
            child: Stack(
              alignment: Alignment
                  .center, // Alinhamento central para as camadas de texto
              children: [
                // Texto branco (borda)
                Text(
                  'É o mensageiro do açúcar elevado, avisando que é hora de cuidar do equilíbrio no corpo!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.06,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 8
                      ..color = const Color(0xFFFFFEFF), // Cor da borda branca
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.25), // Sombra suave
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
                // Texto vermelho
                Text(
                  'É o mensageiro do açúcar elevado, avisando que é hora de cuidar do equilíbrio no corpo!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.06,
                    color: const Color(0xFFEF291D), // Cor vermelha
                  ),
                ),
              ],
            ),
          ),

          // Botões de navegação laterais
          Positioned(
            bottom: size.height * 0.08,
            left: 20, // Ajuste para ficar mais próximo da lateral esquerda
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xFFEF291D),
                size: 48,
              ),
              onPressed: () {
                _audioPlayer.stop(); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonagemLitaPage()),
                ); // Ação do botão voltar
              },
            ),
          ),
          Positioned(
            bottom: size.height * 0.08,
            right: 20, // Ajuste para ficar mais próximo da lateral direita
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFFEF291D),
                size: 48,
              ),
              onPressed: () {
                _audioPlayer.stop(); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonagemBoboPage()),
                ); // Ação do botão avançar
              },
            ),
          ),
        ],
      ),
    );
  }
}
