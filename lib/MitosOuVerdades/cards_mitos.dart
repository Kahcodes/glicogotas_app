import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Adicionado import do SVG
import 'package:glicogotas_app/MitosOuVerdades/diet.dart';
import 'package:glicogotas_app/MitosOuVerdades/fisico.dart';
import 'package:glicogotas_app/MitosOuVerdades/frutas.dart';
import 'package:glicogotas_app/MitosOuVerdades/mel.dart';
import 'package:glicogotas_app/MitosOuVerdades/mito_docesproibidos.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/MitosOuVerdades/mito_v_diabetes.dart';
import 'package:glicogotas_app/main.dart'; // Para o routeObserver global

class MitosOuVerdadesPage extends StatefulWidget {
  const MitosOuVerdadesPage({super.key});

  @override
  MitosOuVerdadesPageState createState() => MitosOuVerdadesPageState();
}

class MitosOuVerdadesPageState extends State<MitosOuVerdadesPage>
    with RouteAware {
  final AudioManager _audioManager = AudioManager();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route); // Usa o routeObserver global
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioManager.stop(); // Para o áudio ao sair
    _audioManager.dispose(); // Dispose do AudioManager
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioManager.stop(); // Para o áudio ao navegar
  }

  // Função para navegar pausando o áudio
  void _navigateToPage(Widget page) {
    _audioManager.stop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
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
              // Header com botões
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
                        Icons.arrow_back_ios_rounded, // Mudou para botão voltar
                        color: Color(0xFF9C6ADE),
                      ),
                      onPressed: () {
                        _audioManager.stop(); // Para o áudio ao voltar
                        Navigator.pop(context); // Usa pop ao invés de push
                      },
                    ),
                    Text(
                      'Mitos ou Verdades',
                      style: GoogleFonts.chewy(
                        color: const Color(0xFF9C6ADE),
                        fontSize: 24.sp,
                      ),
                    ),
                    IconButton(
                      iconSize: 30.sp,
                      icon: const Icon(
                        Icons.settings,
                        color: Color(0xFF9C6ADE),
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
                    // Card Mito 1 - Causas do Diabetes
                    _buildMitoCard(
                      'assets/images/causa.svg',
                      () => _navigateToPage(const MitosVerdadesScreen()),
                    ),

                    // Card Mito 2 - Doces Proibidos
                    _buildMitoCard(
                      'assets/images/doces.svg',
                      () => _navigateToPage(const DocesScreen()),
                    ),

                    // Card Mito 3 - Frutas
                    _buildMitoCard(
                      'assets/images/frutas.svg',
                      () => _navigateToPage(const FrutasScreen()),
                    ),

                    // Card Mito 4 - Dieta
                    _buildMitoCard(
                      'assets/images/diet.svg',
                      () => _navigateToPage(const DietScreen()),
                    ),

                    // Card Mito 5 - Mel
                    _buildMitoCard(
                      'assets/images/mel.svg',
                      () => _navigateToPage(const MelScreen()),
                    ),

                    // Card Mito 6 - Atividade Física
                    _buildMitoCard(
                      'assets/images/ativ_fisica.svg',
                      () => _navigateToPage(const ExerciciosScreen()),
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

  // Widget helper para criar os cards
  Widget _buildMitoCard(String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: imagePath.endsWith('.svg')
              ? SvgPicture.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
        ),
      ),
    );
  }
}
