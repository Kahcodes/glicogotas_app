import 'package:glicogotas_app/MitosOuVerdades/conquistas.dart';
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:animate_do/animate_do.dart';
import 'package:glicogotas_app/configuracoes.dart';

class FrutasScreen extends StatefulWidget {
  const FrutasScreen({super.key});

  @override
  State<FrutasScreen> createState() => _FrutasScreenState();
}

class _FrutasScreenState extends State<FrutasScreen> {
  final List<Map<String, dynamic>> mitosVerdades = [
    {
      'pergunta': 'Quem tem diabetes pode comer frutas?',
      'respostaCorreta': true,
      'titulo': 'É VERDADE!',
      'explicacao':
          'As pessoas com diabetes PODEM comer frutas. Elas são fontes de fibras, vitaminas e minerais importantes para a saúde.',
    },
    {
      'titulo': 'Mas com moderação 🍎🍐🍊',
      'explicacao':
          'A recomendação é consumir até 4 porções por dia, escolhendo frutas mais fibrosas como maçã, pera e laranja.',
    },
    {
      'titulo': 'Atenção à frutose ⚠️',
      'explicacao':
          'Frutas têm frutose, um tipo de açúcar natural. O excesso pode elevar a glicose no sangue.',
    },
    {
      'titulo': 'Equilíbrio é a chave 🔑',
      'explicacao':
          'Inclua frutas na alimentação de forma consciente e converse com o nutricionista para ajustar ao seu plano alimentar.',
    },
  ];

  // Conta apenas a primeira resposta de cada pergunta nesta visita.
  final Set<int> _respostasRegistradas = <int>{};
  bool _temaRegistrado = false;
  Future<void> _somResposta = Future<void>.value();

  void _registrarConclusao() {
    final perguntas = <int>{
      for (var i = 0; i < mitosVerdades.length; i++)
        if (mitosVerdades[i].containsKey('respostaCorreta')) i,
    };
    if (!_temaRegistrado && currentIndex == mitosVerdades.length - 1 &&
        _respostasRegistradas.containsAll(perguntas)) {
      _temaRegistrado = true;
      avisarConquistas(context, ConquistasMitosService.instance.registrar(
        temaConcluido: 'frutas',
      ), esperarSom: _somResposta);
    }
  }

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
      _somResposta = tocarSomRespostaMitos(_player, correta);
      if (_respostasRegistradas.add(currentIndex)) {
        avisarConquistas(context, ConquistasMitosService.instance.registrar(
          pergunta: 'frutas:$currentIndex', correta: correta,
        ), esperarSom: _somResposta);
      }
      _registrarConclusao();
    }
  }

  Future<void> proximaPergunta() async {
    if (currentIndex < mitosVerdades.length - 1) {
      final item = mitosVerdades[currentIndex];
      bool temResposta = item.containsKey('respostaCorreta');

      if (temResposta && !respondeu) return;

      setState(() {
        currentIndex++;
        acertou = null;
        respondeu = false;
      });
      _registrarConclusao();
      await _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> voltarPergunta() async {
    if (currentIndex > 0) {
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
      _registrarConclusao();
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
      backgroundColor: const Color(0xFFFFF8F0),
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
                // Top bar
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 30.sp,
                        icon: const Icon(Icons.question_answer,
                            color: Color(0xFF9C6ADE)),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      IconButton(
                        iconSize: 30.sp,
                        icon: const Icon(Icons.settings,
                            color: Color(0xFF9C6ADE)),
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

                SizedBox(height: 40.h),

                // Título fixo
                RichText(
                  text: TextSpan(
                    text: 'MITO',
                    style: GoogleFonts.chewy(
                      textStyle: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFE53935),
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
                            color: const Color(0xFF43A047),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Conteúdo
                SizedBox(
                  height: 0.5.sh,
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
                      bool mostrarFeedback = respondeu && index == currentIndex;

                      // cores do título das explicações → aqui eu mudei p/ azul
                      Color tituloColor = const Color(0xFF1565C0);
                      String titulo = currentItem['titulo'] ?? '';

                      if (mostrarFeedback) {
                        if (acertou == true) {
                          titulo =
                              "Boa! Você acertou! ${currentItem['titulo'] ?? ''}";
                          tituloColor = Colors.green;
                        } else {
                          titulo = "Errar faz parte!";
                          tituloColor = Colors.red;
                        }
                      }

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5D4FF),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isPergunta || mostrarFeedback) ...[
                              Text(
                                titulo,
                                style: GoogleFonts.chewy(
                                  textStyle: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                    color: tituloColor,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 18.h),
                            ],
                            if (!mostrarFeedback) ...[
                              Text(
                                currentItem['pergunta'] ??
                                    currentItem['explicacao'] ??
                                    '',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.chewy(
                                  textStyle: TextStyle(
                                    fontSize: isPergunta ? 20.sp : 18.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                            if (isPergunta && !respondeu) ...[
                              SizedBox(height: 28.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: FilledButton.icon(
                                      style: FilledButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFD32F2F),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
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
                                      onPressed: () => verificarResposta(false),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: FilledButton.icon(
                                      style: FilledButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF2E7D32),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
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
                                      onPressed: () => verificarResposta(true),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (mostrarFeedback) ...[
                              FadeIn(
                                child: Image.asset(
                                  acertou == true
                                      ? 'assets/images/personagem_acerto.png'
                                      : 'assets/images/personagem_erro.png',
                                  height: 120.h,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                currentItem['explicacao'] ?? '',
                                style: GoogleFonts.chewy(
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const Spacer(),

                // Indicadores
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    mitosVerdades.length,
                    (index) => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == currentIndex
                            ? Colors.deepOrange
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),

                // Botões de navegação
                if (respondeu || !temResposta)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_rounded,
                              size: 48.sp, color: Colors.black),
                          onPressed: currentIndex > 0 ? voltarPergunta : null,
                        ),
                        currentIndex < mitosVerdades.length - 1
                            ? IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded,
                                    size: 48.sp, color: Colors.black),
                                onPressed: proximaPergunta,
                              )
                            : const SizedBox.shrink(),
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
