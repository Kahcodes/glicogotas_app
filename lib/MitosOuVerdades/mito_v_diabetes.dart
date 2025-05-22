import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:animate_do/animate_do.dart';
import 'package:glicogotas_app/configuracoes.dart';

class MitosVerdadesScreen extends StatefulWidget {
  const MitosVerdadesScreen({super.key});

  @override
  State<MitosVerdadesScreen> createState() => _MitosVerdadesScreenState();
}

class _MitosVerdadesScreenState extends State<MitosVerdadesScreen> {
  final List<Map<String, dynamic>> mitosVerdades = [
    {
      'pergunta': 'Diabetes tipo 1 é causado por comer muito açúcar?',
      'respostaCorreta': false,
      'titulo': 'É MITO!🚫',
      'explicacao':
          'Muitas pessoas ainda acreditam que o diabetes tipo 1 surge por causa do consumo excessivo de doces, mas isso não é verdade.',
    },
    {
      'titulo': 'O que realmente acontece?',
      'explicacao':
          'O diabetes tipo 1 é uma condição autoimune: o sistema imunológico ataca as células do pâncreas que produzem insulina.',
    },
    {
      'titulo': 'Nada de culpar o chocolate! 🍫',
      'explicacao':
          'O diabetes tipo 1 não pode ser prevenido e não tem relação com hábitos alimentares.',
    },
    {
      'titulo': 'E o que fazer?',
      'explicacao':
          'Com monitoramento, contagem de carboidratos e uso de insulina, é possível viver com saúde e energia!',
    },
  ];

  int currentIndex = 0;
  bool? acertou;
  bool respondeu = false;
  late final PageController _pageController;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  void verificarResposta(bool respostaUsuario) async {
    final item = mitosVerdades[currentIndex];
    if (item.containsKey('respostaCorreta') && !respondeu) {
      bool correta = item['respostaCorreta'] == respostaUsuario;
      setState(() {
        acertou = correta;
        respondeu = true;
      });
      await _player.play(AssetSource(correta ? 'sounds/acerto.mp3' : 'sounds/erro.mp3'));
    }
  }

  Future<void> proximaPergunta() async {
    if (respondeu && currentIndex < mitosVerdades.length - 1) {
      await _player.play(AssetSource('sounds/page_forward.mp3'));
      setState(() {
        currentIndex++;
        acertou = null;
        respondeu = false;
      });
      await _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> voltarPergunta() async {
    if (currentIndex > 0) {
      await _player.play(AssetSource('sounds/page_back.mp3'));
      setState(() {
        currentIndex--;
        acertou = null;
        respondeu = false;
      });
      await _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int index) {
    // Bloqueia avanço por swipe se não respondeu
    if (!respondeu && index > currentIndex && mitosVerdades[currentIndex].containsKey('respostaCorreta')) {
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      setState(() {
        currentIndex = index;
        acertou = null;
        respondeu = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690), minTextAdapt: true);

    final item = mitosVerdades[currentIndex];

    bool temResposta = item.containsKey('respostaCorreta');

    return Scaffold(
      backgroundColor: const Color(0xFFfff3f6),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/fundo-mito.svg',
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.black),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => const ConfigDialog(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: temResposta && !respondeu
                        ? const NeverScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),
                    onPageChanged: onPageChanged,
                    itemCount: mitosVerdades.length,
                    itemBuilder: (context, index) {
                      final currentItem = mitosVerdades[index];
                      bool isPergunta = currentItem.containsKey('respostaCorreta');
                      bool mostrarTitulo = respondeu && index == currentIndex && temResposta;

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
                              // Mostrar título só depois que responder (para perguntas)
                              if (!isPergunta || mostrarTitulo) ...[
                                Text(
                                  currentItem['titulo'] ?? 'Mito ou Verdade?',
                                  style: GoogleFonts.chewy(
                                    textStyle: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16.h),
                              ],

                              Text(
                                currentItem['pergunta'] ?? currentItem['explicacao'] ?? '',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.chewy(
                                  textStyle: TextStyle(fontSize: 18.sp, color: Colors.black87),
                                ),
                              ),

                              if (isPergunta && !respondeu) ...[
                                SizedBox(height: 20.h),

                                // Imagem neutra durante a seleção, você pode trocar o caminho da imagem aqui:
                                Image.asset(
                                  'assets/images/personagem_neutro.png',
                                  height: 140,
                                ),

                                SizedBox(height: 30.h),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                                        backgroundColor: Colors.green.shade100,
                                      ),
                                      onPressed: () => verificarResposta(true),
                                      child: const Icon(Icons.check, color: Colors.green, size: 40),
                                    ),
                                    SizedBox(width: 40.w),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                                        backgroundColor: Colors.red.shade100,
                                      ),
                                      onPressed: () => verificarResposta(false),
                                      child: const Icon(Icons.close, color: Colors.red, size: 40),
                                    ),
                                  ],
                                ),
                              ],

                              if (respondeu && index == currentIndex) ...[
                                SizedBox(height: 20.h),
                                Text(
                                  acertou!
                                      ? 'Boa! Você acertou! 🎉'
                                      : 'Poxa, você errou, mas tá tudo bem! Vamos entender juntos:',
                                  style: GoogleFonts.chewy(
                                    textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16.h),
                                FadeIn(
                                  child: Image.asset(
                                    acertou!
                                        ? 'assets/images/personagem_acerto.png'
                                        : 'assets/images/personagem_erro.png',
                                    height: 150,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  currentItem['explicacao'] ?? '',
                                  style: GoogleFonts.chewy(
                                    textStyle: TextStyle(fontSize: 16.sp, color: Colors.black54),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    mitosVerdades.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == currentIndex ? Colors.pink : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                        onPressed: currentIndex > 0 ? voltarPergunta : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                        onPressed: respondeu && currentIndex < mitosVerdades.length - 1 ? proximaPergunta : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
