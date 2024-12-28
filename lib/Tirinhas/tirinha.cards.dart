import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_app/home.dart'; // Importa a tela inicial
import 'package:glicogotas_app/configuracoes.dart'; // Importa o diálogo de configurações
import 'package:glicogotas_app/Tirinhas/tirinha_docura.dart'; // Importa a página Tirinha
import 'package:glicogotas_app/Tirinhas/tirinha_insulina.dart';

class TirinhaCardsPage extends StatefulWidget {
  const TirinhaCardsPage({super.key});

  @override
  TirinhaCardsPageState createState() => TirinhaCardsPageState();
}

class TirinhaCardsPageState extends State<TirinhaCardsPage> with RouteAware {
  final AudioManager _audioManager = AudioManager();
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioManager.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfff3f6), // Fundo da página
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              // Título "Selecione um Capítulo" com ícones
              Positioned(
                top: 40.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Ícone "Home"
                    IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(
                        Icons.home_rounded,
                        color: Color(0xFFF4719C),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TelaHome()),
                        );
                      },
                    ),
                    Text(
                      'Selecione uma tirinha', // Título da página
                      style: GoogleFonts.chewy(
                        color: const Color(0xFF37ABDC),
                        fontSize: 24.sp,
                      ),
                    ),
                    // Ícone "Configurações"
                    IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFFF4719C), // Cor do ícone ajustada
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
                  ],
                ),
              ),

              // Grid de cards com espaçamento ajustado
              Padding(
                padding: EdgeInsets.only(
                    top: 120.h), // Ajusta os cards mais para baixo
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16.w),
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  children: [
                    // Card 1
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Tirinha()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/tirinha-docura-capa.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Card 2
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TirinhaInsulina()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/tirinha-insu-capa.png', // Exemplo de imagem
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Card 3

                    // Card 4 (Exemplo adicional)
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
