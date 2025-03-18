import 'package:flutter/material.dart';
import 'package:glicogotas_app/Livro/cards.dart';
import 'package:glicogotas_app/Livro/diabetes-livro/diabetes1.dart';
import 'package:glicogotas_app/Livro/diabetes-livro/diabetes2.dart';
import 'package:glicogotas_app/Livro/diabetes-livro/diabetes3.dart';
import 'package:glicogotas_app/Livro/diabetes-livro/diabetes4.dart';
import 'package:glicogotas_app/Livro/diabetes-livro/diabetes5.dart';
import 'package:glicogotas_app/Livro/diabetes-livro/diabetes6.dart';
import 'package:glicogotas_app/configuracoes.dart';
import 'package:glicogotas_app/controleaudio.dart';
import 'package:glicogotas_app/main.dart';
import 'package:glicogotas_app/sqlite.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CapaPage extends StatefulWidget {
  const CapaPage({super.key});

  @override
  State<CapaPage> createState() => _CapaPageState();
}

class _CapaPageState extends State<CapaPage> with RouteAware {
  final AudioManager _audioManager = AudioManager();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = const [
    CapaContent(),
    Diabetes1Page(),
    Diabetes2Page(),
    Diabetes3Page(),
    Diabetes4Page(),
    Diabetes5Page(),
    Diabetes6Page(),
  ];

  @override
  void initState() {
    super.initState();
    _audioManager.play('audio/titulo.mp3', context);
    _navigateToSavedPage();
  }

  Future<void> _navigateToSavedPage() async {
    final savedPage = await PageDatabase.instance.getCurrentPage();
    if (savedPage > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => _getPageByNumber(savedPage),
          ),
        );
      });
    }
  }

  Widget _getPageByNumber(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= _pages.length) {
      return _pages[pageNumber - 1];
    }
    return const CapaPage();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _audioManager.stop();
    _audioManager.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    _audioManager.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF265F95),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double scale = 1.0;
                    double opacity = 1.0;

                    if (_pageController.position.haveDimensions) {
                      double page = _pageController.page ?? 0.0;
                      scale = (1 - (index - page).abs()).clamp(0.85, 1.0);
                      opacity = (1 - (index - page).abs()).clamp(0.5, 1.0);
                    }

                    return Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity,
                        child: _pages[index],
                      ),
                    );
                  },
                );
              },
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.yellow
                          : Colors.white.withAlpha((0.5 * 255).toInt()),

                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            if (_currentPage > 0)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Color.fromARGB(0, 255, 255, 255)),
                  onPressed: () {
                    _audioManager.stop();
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            if (_currentPage < _pages.length - 1)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Color.fromARGB(0, 255, 255, 255)),
                  onPressed: () {
                    _audioManager.stop();
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CapaContent extends StatelessWidget {
  const CapaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final audioManager = AudioManager();
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.h, left: 16.w),
                  child: IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      audioManager.stop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LivroCardsPage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.h, right: 16.w),
                  child: IconButton(
                    iconSize: 30.sp,
                    icon: const Icon(
                      Icons.settings,
                      color: Color.fromARGB(255, 255, 255, 255),
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
              ],
            ),
            SizedBox(height: 100.h),
            CustomPaint(
              painter: ArcTextPainter(),
              child: Container(height: 80.h),
            ),
            Text(
              'DESCOMPLICANDO',
              style: GoogleFonts.chewy(fontSize: 36.sp, color: Colors.yellow),
            ),
            Text(
              'o Diabetes',
              style: GoogleFonts.chewy(fontSize: 36.sp, color: Colors.yellow),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Image.asset(
            "assets/images/talita_capa.png",
            height: 290.h,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0.08.sh,
          right: 5.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Text(
                  'Avançar',
                  style: GoogleFonts.chewy(
                    fontSize: 28.sp,
                    color: Colors.yellow,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.yellow,
                  size: 36.sp,
                ),
                onPressed: () {
                  PageDatabase.instance.saveCurrentPage(1);
                  audioManager.stop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Diabetes1Page()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Pintura do texto em arco
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
