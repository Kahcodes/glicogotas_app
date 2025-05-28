import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/Tirinhas/agua_vai_tirinha.dart';
import 'package:glicogotas_app/Tirinhas/bateria_fraca_tirinha.dart';
import 'package:glicogotas_app/Tirinhas/glicoamigos_tirinha.dart';
import 'package:glicogotas_app/Tirinhas/missao_ac_tirinha.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/Tirinhas/tirinha_docura.dart';
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
      backgroundColor: const Color(0xFFfff3f6),
      body: LayoutBuilder(
        builder: (context, constraints) {
          ScreenUtil.init(
            context,
            designSize: const Size(360, 690),
            minTextAdapt: true,
          );

          return Stack(
            children: [
              Positioned(
                top: 40.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(
                        Icons.home_rounded,
                        color: Color(0xFFF4719C),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TelaHome()),
                        );
                      },
                    ),
                    Text(
                      'Selecione uma tirinha',
                      style: GoogleFonts.chewy(
                        color: const Color(0xFF37ABDC),
                        fontSize: 24.sp,
                      ),
                    ),
                    IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFFF4719C),
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 120.h),
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16.w),
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  children: [
                    // Card 1
                    _buildCard(
                      imagePath: 'assets/images/tirinha-docura-capa.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Tirinha()),
                        );
                      },
                    ),
                    // Card 2
                    _buildCard(
                      imagePath: 'assets/images/tirinha-insu-capa.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TirinhaInsulina()),
                        );
                      },
                    ),
                    // Card 3
                    _buildCard(
                      imagePath: 'assets/images/glicoamigos-card.png', 
                      onTap: () {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TirinhaGlicoamigos()),
                        );
                        
                      },
                    ),
                    // Card 4
                    _buildCard(
                      imagePath: 'assets/images/tirinha-aguavai.png', 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TirinhaAgua()),
                        );
                      },
                    ),
                    // Card 5
                    _buildCard(
                      imagePath: 'assets/images/bateria-fraca-tirinha.png', 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TirinhaBateria()),
                        );
                      },
                    ),
                    // Card 6
                    _buildCard(
                      imagePath: 'assets/images/tirinha-missao.png', 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TirinhaMissao()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCard({required String imagePath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
