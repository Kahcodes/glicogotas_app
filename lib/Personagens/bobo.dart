import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/fe.dart';
import 'package:glicogotas_app/Personagens/rei.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Certifique-se de que routeObserver está importado

class PersonagemBoboPage extends StatefulWidget {
  const PersonagemBoboPage({super.key});

  @override
  PersonagemBoboPageState createState() => PersonagemBoboPageState();
}

class PersonagemBoboPageState extends State<PersonagemBoboPage>
    with RouteAware {
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
    _audioManager.play(
        'audio/audioPersonagens/bobo.mp3', context); // Reproduz o áudio
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
    _audioManager.play('audio/audioPersonagens/bobo.mp3',
        context); // Reinicia o áudio ao voltar
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
              'assets/images/fundo-bobo.svg',
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
                _audioManager.stop(); // Para o áudio ao ir para a tela inicial
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

          // Nome do personagem (Bobo da Hipo) centralizado
          Positioned(
            top: size.height * 0.15,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Texto branco (borda)
                Text(
                  'Bobo da Hipo',
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.13,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 8
                      ..color = const Color(0xFFFFFEFF),
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
                // Texto verde
                Text(
                  'Bobo da Hipo',
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.13,
                    color: const Color(0xFF00D287),
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
                'assets/images/eclipse-bobo.svg',
                height: size.height * 0.36,
              ),
            ),
          ),

          // Personagem sobreposta à bola
          Positioned(
            top: size.height * 0.29,
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/bobo-person.svg',
                height: size.height * 0.38,
              ),
            ),
          ),

          // Descrição do personagem
          Positioned(
            bottom: size.height * 0.20,
            left: 20,
            right: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Texto branco (borda)
                Text(
                  'O Bobo da Hipo aparece quando o açúcar está baixo e nos faz entrar em muita confusão!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.06,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 8
                      ..color = const Color(0xFFFFFEFF),
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
                // Texto verde
                Text(
                  'O Bobo da Hipo aparece quando o açúcar está baixo e nos faz entrar em muita confusão!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.chewy(
                    fontSize: size.width * 0.06,
                    color: const Color(0xFF00D287),
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
                color: Color(0xFF00D287),
                size: 48,
              ),
              onPressed: () {
                _audioManager.stop(); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonagemReiPage()),
                );
              },
            ),
          ),
          Positioned(
            bottom: size.height * 0.08,
            right: 20, // Ajuste para ficar mais próximo da lateral direita
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF00D287),
                size: 48,
              ),
              onPressed: () {
                _audioManager.stop(); // Para o áudio ao navegar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonagemFePage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
