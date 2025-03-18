import 'package:flutter/material.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/sobre_page.dart';

class ConfigDialog extends StatefulWidget {
  const ConfigDialog({super.key});

  @override
  ConfigDialogState createState() => ConfigDialogState();
}

class ConfigDialogState extends State<ConfigDialog> {
  @override
  Widget build(BuildContext context) {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: true);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(); // Fecha o diálogo ao tocar fora
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10.w),
        child: GestureDetector(
          onTap: () {}, // Impede o fechamento ao tocar dentro do diálogo
          child: Center(
            child: Container(
              width: 300.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF008AD7),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    blurRadius: 10.r,
                    offset: Offset(0, 5.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título e botão voltar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Color(0xFFFEDE74)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'CONFIGURAÇÕES',
                            style: GoogleFonts.chewy(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFCB44E),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withAlpha((0.5 * 255).toInt()),
                                  offset: Offset(2.w, 2.h),
                                  blurRadius: 4.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48.w), // Espaço para balancear o layout
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Controle de som
                  FutureBuilder(
                    future: configuracoesProvider.getSoundOn(),
                    builder: (context, snapshot) {
                      return _buildSwitchOption('SOM', snapshot.data ?? true,
                          (value) {
                        configuracoesProvider.switchSoundOn();
                      });
                    },
                  ),

                  SizedBox(height: 20.h),

                  // Controle de música
                  FutureBuilder(
                    future: configuracoesProvider.getMusicOn(),
                    builder: (context, snapshot) {
                      return _buildSwitchOption('MÚSICA', snapshot.data ?? true,
                          (value) {
                        configuracoesProvider.switchMusicOn();
                      });
                    },
                  ),

                  SizedBox(height: 20.h),

                  /* Controle de volume
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'VOLUME',
                        style: GoogleFonts.chewy(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFFFFF),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2.w, 2.h),
                              blurRadius: 4.r,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 4.h,
                            thumbColor: const Color(0xFFFCB44E),
                            activeTrackColor: const Color(0xFFFCB44E),
                            inactiveTrackColor: const Color(0xFFFFFFFF),
                          ),
                          child: Slider(
                            value: configuracoesProvider.volume,
                            min: 0,
                            max: 1,
                            onChanged: (value) {
                              configuracoesProvider.setVolume(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  */

                  SizedBox(height: 20.h),

                  // Idioma
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'IDIOMA:',
                      style: GoogleFonts.chewy(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFFFFF),
                        shadows: [
                          Shadow(
                            color: Colors.black.withAlpha((0.5 * 255).toInt()),

                            offset: Offset(2.w, 2.h),
                            blurRadius: 4.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLanguageButton('Português', configuracoesProvider),
                      SizedBox(width: 10.w),
                      _buildLanguageButton('Español', configuracoesProvider),
                      SizedBox(width: 10.w),
                      _buildLanguageButton('English', configuracoesProvider),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Ícone de ajuda
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SOBRE',
                        style: GoogleFonts.podkova(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFFFFF),
                          shadows: [
                            Shadow(
                              color: Colors.black.withAlpha((0.5 * 255).toInt()),
                              offset: Offset(2.w, 2.h),
                              blurRadius: 4.r,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SobrePage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.help_outline,
                          color: Color(0xFFFEDE74),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchOption(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.chewy(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFFFFF),
            shadows: [
              Shadow(
                color: Colors.black.withAlpha((0.5 * 255).toInt()),
                offset: Offset(2.w, 2.h),
                blurRadius: 4.r,
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: const Color(0xFFFCB44E),
          inactiveTrackColor: const Color(0xFFFFFFFF),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildLanguageButton(
      String language, ConfiguracoesRepository provider) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: provider.language == language
            ? const Color(0xFFFCB44E)
            : const Color(0xFF37ABDC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        shadowColor: Colors.black.withAlpha((0.5 * 255).toInt()),
        elevation: 5,
      ),
      onPressed: () {
        provider.setLanguage(language);
      },
      child: Text(
        language,
        style: GoogleFonts.chewy(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withAlpha((0.5 * 255).toInt()),
              offset: Offset(2.w, 2.h),
              blurRadius: 4.r,
            ),
          ],
        ),
      ),
    );
  }
}
