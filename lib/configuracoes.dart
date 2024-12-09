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
  bool _musicaOn = true; // Estado do switch Música (on/off)
  double _volumeValue = 0.7;
  String _selectedLanguage = 'Português';

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
                  // "Configurações" e voltar
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
                      const SizedBox(width: 48), // Espaço vazio para balancear
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Ajuste de som com Switch on/off
                  FutureBuilder(
                      future: configuracoesProvider.getSoundOn(),
                      builder: (context, snapshot) {
                        return _buildSwitchOption('SOM', snapshot.data ?? true,
                            (value) {
                          setState(() {
                            configuracoesProvider.switchSoundOn();
                          });
                        });
                      }),

                  const SizedBox(height: 20),

                  // Ajuste de música com Switch on/off
                  _buildSwitchOption('MÚSICA', _musicaOn, (value) {
                    setState(() {
                      _musicaOn = value;
                    });
                  }),

                  const SizedBox(height: 20),

                  // Ajuste de volume com Slider
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
                            value: _volumeValue,
                            min: 0,
                            max: 1,
                            onChanged: (value) {
                              setState(() {
                                _volumeValue = value;
                              });
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
                      _buildLanguageButton('Português'),
                      const SizedBox(width: 10),
                      _buildLanguageButton('Español'),
                      const SizedBox(width: 10),
                      _buildLanguageButton('English'),
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
                      Icon(
                        Icons.help_outline,
                        color: const Color(0xFFFEDE74),
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

  Widget _buildLanguageButton(String language) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedLanguage == language
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
        setState(() {
          _selectedLanguage = language;
        });
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
}
