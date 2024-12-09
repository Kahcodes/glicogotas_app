import 'package:flutter/material.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
        insetPadding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {}, // Impede o fechamento ao tocar dentro do diálogo
          child: Center(
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF008AD7),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
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
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFCB44E),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 48), // Espaço para balancear o layout
                    ],
                  ),
                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  // Controle de volume
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'VOLUME',
                        style: GoogleFonts.chewy(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFFFFF),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 4,
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

                  const SizedBox(height: 20),

                  // Idioma
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'IDIOMA:',
                      style: GoogleFonts.chewy(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFFFFF),
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLanguageButton('Português', configuracoesProvider),
                      const SizedBox(width: 10),
                      _buildLanguageButton('Español', configuracoesProvider),
                      const SizedBox(width: 10),
                      _buildLanguageButton('English', configuracoesProvider),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Ícone de ajuda
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AJUDA',
                        style: GoogleFonts.podkova(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFFFFF),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.help_outline,
                        color: Color(0xFFFEDE74),
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFFFFF),
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 4,
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
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shadowColor: Colors.black.withOpacity(0.5),
        elevation: 5,
      ),
      onPressed: () {
        provider.setLanguage(language);
      },
      child: Text(
        language,
        style: GoogleFonts.chewy(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}
