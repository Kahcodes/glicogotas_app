import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_app/home.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/MitosOuVerdades/mito_v_diabetes.dart';


class MitosOuVerdadesPage extends StatefulWidget {
  const MitosOuVerdadesPage({super.key});

  @override
  MitosOuVerdadesPageState createState() => MitosOuVerdadesPageState();
}

class MitosOuVerdadesPageState extends State<MitosOuVerdadesPage> with RouteAware {
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
                      'Mitos ou Verdades',
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

              // Grid de cards
              Padding(
                padding: EdgeInsets.only(top: 120.h),
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16.w),
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  children: [
                    // Card Mito 1
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MitosVerdadesScreen()),
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
                              'assets/images/card-mv-diabete.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Card Mito 2
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MitosVerdadesScreen()),
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
                              'assets/images/mito2-capa.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Adicione mais cards conforme necessário...
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