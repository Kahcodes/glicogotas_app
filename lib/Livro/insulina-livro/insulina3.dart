import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/Livro/cards.dart';
import 'package:glicogotas_app/Livro/insulina-livro/insulina2.dart';
import 'package:glicogotas_app/Livro/insulina-livro/insulina4.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/main.dart'; // Importa o routeObserver
import 'package:glicogotas_app/sqlite.dart';

class Insulina3Page extends StatefulWidget {
  const Insulina3Page({super.key});

  @override
  State<Insulina3Page> createState() => _Insulina3PageState();
}

class _Insulina3PageState extends State<Insulina3Page> with RouteAware {
  final AudioManager _audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    PageDatabase.instance.saveCurrentPage(3); // Salva o número da página atual
    _audioManager.play('audio/pagina3insu.mp3', context); // Reproduz o áudio
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
        'audio/pagina2insu.mp3', context); // Reinicia o áudio ao voltar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfffcf3),
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              // Fundo da página
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/fundoinsulinas.svg',
                  fit: BoxFit.fill,
                ),
              ),

              // Personagem Lita
              Positioned(
                top: 0.35.sh,
                left: 0.02.sw,
                right: 0.02.sw,
                child: SvgPicture.asset(
                  'assets/images/lita-pensa.svg',
                  width: 0.5.sw,
                  height: 0.5.sh,
                ),
              ),

              // Balão de fala
              Positioned(
                top: 0.14.sh,
                left: 0.02.sw,
                right: 0.02.sw,
                child: SvgPicture.asset(
                  'assets/images/balao-ins-page3.svg',
                  width: 0.7.sw,
                ),
              ),

              // Ícone Home (por cima dos botões invisíveis)
              Positioned(
                top: 40.h,
                left: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(
                    Icons.menu_book,
                    color: Color(0xFF265F95),
                  ),
                  onPressed: () {
                    _audioManager
                        .stop(); // Para o áudio ao voltar à tela inicial
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LivroCardsPage()),
                    );
                  },
                ),
              ),

              // Ícone Configurações (por cima dos botões invisíveis)
              Positioned(
                top: 40.h,
                right: 16.w,
                child: IconButton(
                  iconSize: 30.sp,
                  icon: const Icon(
                    Icons.settings,
                    color: Color(0xFF265F95),
                  ),
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

              // Botão de navegação anterior
              Positioned(
                bottom: 0.08.sh,
                left: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Color(0xFF265F95),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    _audioManager.stop();
                    PageDatabase.instance.saveCurrentPage(2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Insulina2Page()),
                    );
                  },
                ),
              ),

              // Botão de navegação próxima
              Positioned(
                bottom: 0.08.sh,
                right: 20.w,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF265F95),
                    size: 48.sp,
                  ),
                  onPressed: () {
                    _audioManager.stop();
                    PageDatabase.instance.saveCurrentPage(4);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Insulina4Page()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
