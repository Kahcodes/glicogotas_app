// ignore_for_file: use_key_in_widget_constructors

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
      'pergunta': 'O DM1 é causado por comer muito açúcar?',
      'respostaCorreta': false,
      'titulo': 'MITO! 🚫',
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
      await _player
          .play(AssetSource(correta ? 'sounds/acerto.mp3' : 'sounds/erro.mp3'));
    }
  }

  Future<void> proximaPergunta() async {
    if (currentIndex < mitosVerdades.length - 1) {
      final item = mitosVerdades[currentIndex];
      bool temResposta = item.containsKey('respostaCorreta');

      // Se tem resposta e ainda não respondeu, não pode avançar
      if (temResposta && !respondeu) {
        return;
      }

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
    final currentItem = mitosVerdades[currentIndex];
    bool temResposta = currentItem.containsKey('respostaCorreta');

    // Se está tentando avançar de uma pergunta não respondida, volta para a pergunta
    if (!respondeu && index > currentIndex && temResposta) {
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
    ScreenUtil.init(context,
        designSize: const Size(360, 690), minTextAdapt: true);

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
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 30.sp,
                        icon: const Icon(Icons.arrow_back_ios_rounded,
                            color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      IconButton(
                        iconSize: 30.sp,
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
                RichText(
                  text: TextSpan(
                    text: 'MITO',
                    style: GoogleFonts.chewy(
                      textStyle: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFEF291D),
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: ' ou ',
                        style: TextStyle(color: const Color(0xFF33363F)),
                      ),
                      TextSpan(
                        text: 'VERDADE?',
                        style: GoogleFonts.chewy(
                          textStyle: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF01C881),
                          ),
                        ),
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
                      bool isPergunta =
                          currentItem.containsKey('respostaCorreta');
                      bool mostrarTitulo =
                          respondeu && index == currentIndex && temResposta;

                      return Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5D4FF),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight,
                                  ),
                                  child: IntrinsicHeight(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (!isPergunta || mostrarTitulo) ...[
                                          Text(
                                            currentItem['titulo'] ??
                                                'Mito ou Verdade?',
                                            style: GoogleFonts.chewy(
                                              textStyle: TextStyle(
                                                  fontSize: 25.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xFFEF291D)),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 16.h),
                                        ],
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              currentItem['pergunta'] ??
                                                  currentItem['explicacao'] ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.chewy(
                                                textStyle: TextStyle(
                                                    fontSize: 20.sp,
                                                    color: const Color(
                                                        0xFF33363F)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (isPergunta && !respondeu) ...[
                                          SizedBox(height: 10.h),
                                          Image.asset(
                                            'assets/images/personagem_neutro.png',
                                            height: 180.h,
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: FilledButton.icon(
                                                  style: FilledButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFFA81A1A),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.r)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12.h),
                                                  ),
                                                  icon: const Icon(Icons.close,
                                                      color: Colors.white),
                                                  label: Text(
                                                    'Mito',
                                                    style: GoogleFonts.chewy(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp),
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      verificarResposta(false),
                                                ),
                                              ),
                                              SizedBox(width: 16.w),
                                              Expanded(
                                                child: FilledButton.icon(
                                                  style: FilledButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF00A369),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.r)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12.h),
                                                  ),
                                                  icon: const Icon(Icons.check,
                                                      color: Colors.white),
                                                  label: Text(
                                                    'Verdade',
                                                    style: GoogleFonts.chewy(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp),
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      verificarResposta(true),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        if (respondeu &&
                                            index == currentIndex) ...[
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
                                              height: 120,
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                currentItem['explicacao'] ?? '',
                                                style: GoogleFonts.chewy(
                                                  textStyle: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.black54),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == currentIndex
                            ? Colors.pink
                            : Colors.grey.shade300,
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
                        icon: const Icon(Icons.arrow_back_ios_rounded,
                            size: 48, color: Colors.black),
                        onPressed: currentIndex > 0 ? voltarPergunta : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 48, color: Colors.black),
                        onPressed: () {
                          final currentItem = mitosVerdades[currentIndex];
                          bool temResposta =
                              currentItem.containsKey('respostaCorreta');

                          // Pode avançar se:
                          // 1. Não é a última página E
                          // 2. Se tem resposta, já deve ter respondido OU se não tem resposta, pode avançar
                          if (currentIndex < mitosVerdades.length - 1 &&
                              (!temResposta || respondeu)) {
                            proximaPergunta();
                          }
                        },
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
