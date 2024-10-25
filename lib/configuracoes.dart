import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfigDialog extends StatefulWidget {
  const ConfigDialog({super.key});

  @override
  ConfigDialogState createState() => ConfigDialogState();
}

class ConfigDialogState extends State<ConfigDialog> {
  bool _somOn = true; // Estado do switch Som (on/off)
  bool _musicaOn = true; // Estado do switch Música (on/off)
  double _volumeValue = 0.7;
  String _selectedLanguage = 'Português';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
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
                    icon:
                        const Icon(Icons.arrow_back, color: Color(0xFFFEDE74)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'CONFIGURAÇÕES',
                        style: GoogleFonts.chewy(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFCB44E), // Cor FCB44E
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
                      width:
                          48), // Espaço vazio para balancear o ícone de voltar
                ],
              ),
              const SizedBox(height: 20),

              // Ajuste de som com Switch on/off
              _buildSwitchOption('SOM', _somOn, (value) {
                setState(() {
                  _somOn = value;
                });
              }),

              const SizedBox(height: 20), // Espaçamento ajustado

              // Ajuste de música com Switch on/off
              _buildSwitchOption('MÚSICA', _musicaOn, (value) {
                setState(() {
                  _musicaOn = value;
                });
              }),

              const SizedBox(height: 20), // Espaçamento ajustado

              // Ajuste de volume com Slider
              _buildSliderOption('VOLUME', _volumeValue, (value) {
                setState(() {
                  _volumeValue = value;
                });
              }),

              const SizedBox(height: 20),

              // idioma
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'IDIOMA:',
                  style: GoogleFonts.chewy(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFFFFF), // Cor FCB44E
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
              const SizedBox(height: 10), // Espaço entre "Idioma" e os botões
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

              //  ícone ?
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
                    color: const Color(0xFFFEDE74), // Ícone de ajuda
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar as opções de controle deslizante
  Widget _buildSliderOption(
      String title, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.chewy(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFFFFF), // Títulos em FCB44E
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4, // Altura da barra
            thumbColor: const Color(0xFFFCB44E), // Cor da bolinha
            activeTrackColor: const Color(0xFFFCB44E), // Parte preenchida
            inactiveTrackColor: const Color(0xFFFFFFFF), // Parte não preenchida
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 1,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  // Função para criar os botões de idioma
  Widget _buildLanguageButton(String language) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedLanguage == language
            ? const Color(0xFFFCB44E) // Quando selecionado
            : const Color(0xFF37ABDC), // Quando não selecionado
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shadowColor: Colors.black.withOpacity(0.5), // Sombra dos botões
        elevation: 5, // Adiciona sombra visível
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
          color: Colors.white, // Texto sempre branco
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

  // Função para criar as opções de switch (on/off) com sombra
  Widget _buildSwitchOption(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.chewy(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFFFFF), // Títulos em FCB44E
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
          activeColor: const Color(0xFF00D287), // Cor do switch quando ligado
          inactiveTrackColor:
              const Color(0xFFF4719C), // Cor do switch quando desligado
          onChanged: onChanged,
        ),
      ],
    );
  }
}
