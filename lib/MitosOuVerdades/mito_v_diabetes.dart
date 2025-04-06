import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/configuracoes.dart';

class MitosVerdadesScreen extends StatefulWidget {
  const MitosVerdadesScreen({super.key});

  @override
  State<MitosVerdadesScreen> createState() => _MitosVerdadesScreenState();
}

class _MitosVerdadesScreenState extends State<MitosVerdadesScreen> {
  final List<Map<String, String>> mitosVerdades = [
    {
      'titulo': 'É MITO!🚫',
      'texto':
          'Muitas pessoas ainda acreditam que o diabetes tipo 1  surge por causa do consumo excessivo de doces, mas isso não é verdade. Vem entender o que acontece:',
    },
    // Você pode adicionar mais aqui!
    {
      'titulo': 'O que realmente acontece?',
      'texto':
          'O diabetes tipo 1  é uma condição autoimune, o que significa que o próprio sistema imunológico ataca as células do pâncreas responsáveis por produzir insulina. Isso impede o corpo de regular a glicose no sangue corretamente.',
    },
    {
      'titulo': 'Nada de culpar o chocolate! 🍫',
      'texto':
          'O diabetes tipo 1 não pode ser prevenido e não  tem relação com hábitos alimentares. Ele pode aparecer em qualquer pessoa, em qualquer idade, mas é mais comum em crianças e adolescentes.',
    },
       {
      'titulo': 'E o que fazer?',
      'texto':
          'Quem tem diabetes tipo 1  precisa monitorar a glicose, contar carboidratos e usar insulina diariamente. Mas com informação e tratamento adequado, é possível viver uma vida saudável e cheia de energia!',
    },
  ];

  int currentIndex = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _navigateToPage(int index) {
    if (index >= 0 && index < mitosVerdades.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentIndex = index;
      });
    }
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
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/fundo-hist.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                    child: Row(
                      children: [
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        IconButton(
                          iconSize: 30.sp,
                          icon: const Icon(Icons.settings, color: Colors.black),
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
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: mitosVerdades.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        final item = mitosVerdades[index];
                        return Padding(
                          padding: EdgeInsets.all(24.w),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item['titulo'] ?? '',
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                    color: item['titulo'] == 'MITO' ? Colors.red : Colors.green,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  item['texto'] ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        mitosVerdades.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 8.h,
                          width: 8.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex == index ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 50.h,
                left: 20.w,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded, size: 48, color: Colors.black),
                  onPressed: () => _navigateToPage(currentIndex - 1),
                ),
              ),
              Positioned(
                bottom: 50.h,
                right: 20.w,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 48, color: Colors.black),
                  onPressed: () => _navigateToPage(currentIndex + 1),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
