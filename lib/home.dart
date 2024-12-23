import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Personagens/glicogotas.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/iniciar.dart.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_app/Tirinhas/tirinha.cards.dart';
import 'package:glicogotas_app/Livro/cards.dart';
import 'package:glicogotas_app/jogos.dart';
import 'package:provider/provider.dart';
import 'configuracoes.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  TelaHomeState createState() => TelaHomeState();
}

class TelaHomeState extends State<TelaHome> {
  final AudioManager _audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    final configProvider = Provider.of<ConfiguracoesRepository>(
      context,
      listen: false,
    );

    // Escuta as mudanças na configuração de música
    configProvider.addListener(() {
      if (configProvider.musicOn) {
        _audioManager.play('audio/musica.mp3', context);
      } else {
        _audioManager.stop();
      }
    });

    // Inicia a música se a configuração estiver habilitada
    if (configProvider.musicOn) {
      _audioManager.setVolume(0.3);
      _audioManager.play('audio/musica.mp3', context);
    }
  }

  @override
  void dispose() {
    _audioManager.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Fundo com decoração em SVG
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/decoracao.svg',
                fit: BoxFit.cover,
              ),
            ),

            // Ícone de voltar
            Positioned(
              top: 40,
              left: 16,
              child: IconButton(
                iconSize: 30,
                icon:
                    const Icon(Icons.arrow_back_ios, color: Color(0xFF265F95)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaInicial(),
                    ),
                  );
                },
              ),
            ),

            // Ícone de configurações
            Positioned(
              top: 40,
              right: 16,
              child: IconButton(
                iconSize: 30,
                icon: const Icon(Icons.settings, color: Color(0xFF265F95)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ConfigDialog();
                    },
                  );
                },
              ),
            ),

            // Conteúdo principal
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Texto e imagem
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ícone principal
                        SizedBox(
                          width: 131,
                          height: 282,
                          child: ClipRect(
                            child: Image.asset(
                              'assets/images/talita_icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Como vamos',
                              style: GoogleFonts.sansitaSwashed(
                                color: const Color(0xFF37ABDC),
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'aprender',
                                    style: GoogleFonts.sansitaSwashed(
                                      color: const Color(0xFFF4719C),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' hoje?',
                                    style: GoogleFonts.sansitaSwashed(
                                      color: const Color(0xFF37ABDC),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
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

                  const SizedBox(height: 40),

                  // Botão PERSONAGENS
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonagensPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D287),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: SizedBox(
                      width: 154,
                      height: 32,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              "assets/images/person.svg",
                              fit: BoxFit.cover,
                              height: 23,
                              width: 23,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'PERSONAGENS',
                              style: GoogleFonts.podkova(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Botão LIVRO
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LivroCardsPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: SizedBox(
                      width: 153,
                      height: 32,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              "assets/images/livro.svg",
                              fit: BoxFit.cover,
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'LIVRO',
                              style: GoogleFonts.podkova(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Botão TIRINHAS
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TirinhaCardsPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFCB44E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: SizedBox(
                      width: 153,
                      height: 32,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              "assets/images/historia.svg",
                              fit: BoxFit.cover,
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'TIRINHAS',
                              style: GoogleFonts.podkova(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Botão JOGOS
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JogosPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: SizedBox(
                      width: 153,
                      height: 32,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              "assets/images/jogos.svg",
                              fit: BoxFit.cover,
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'JOGOS',
                              style: GoogleFonts.podkova(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
