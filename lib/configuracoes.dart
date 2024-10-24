import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfigDialog extends StatefulWidget {
  const ConfigDialog({super.key});

  @override
  ConfigDialogState createState() =>
      ConfigDialogState(); // Classe agora pública
}

class ConfigDialogState extends State<ConfigDialog> {
  double _somValue = 0.5;
  double _musicaValue = 0.5;
  double _volumeValue = 0.7;
  String _selectedLanguage = 'Português'; // Armazena o idioma selecionado

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Fundo transparente
      insetPadding: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
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
              // Linha com o ícone de voltar, título, e ícone de configuração
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: Color(0xFF37ABDC)),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Fecha o diálogo e volta à tela anterior
                    },
                  ),
                  Text(
                    'CONFIGURAÇÕES',
                    style: GoogleFonts.podkova(
                      fontSize: 22,
                      fontWeight: FontWeight.bold, // Fonte BOLD
                      color: const Color(0xFF37ABDC),
                    ),
                  ),
                  Icon(Icons.settings,
                      color:
                          Color(0xFFFCB44E)), // Ícone decorativo da engrenagem
                ],
              ),
              const SizedBox(height: 30), // Aumentado para dar mais espaço

              // Slider para som
              _buildSliderOption('SOM', _somValue, (newValue) {
                setState(() {
                  _somValue = newValue;
                });
              }),

              const SizedBox(
                  height: 10), // Espaçamento adicional entre os sliders

              // Slider para música
              _buildSliderOption('MÚSICA', _musicaValue, (newValue) {
                setState(() {
                  _musicaValue = newValue;
                });
              }),

              const SizedBox(
                  height: 10), // Espaçamento adicional entre os sliders

              // Slider para volume
              _buildSliderOption('VOLUME', _volumeValue, (newValue) {
                setState(() {
                  _volumeValue = newValue;
                });
              }),

              const SizedBox(height: 20),

              // Seção de Idioma com botões horizontais
              _buildLanguageSelector(),

              const SizedBox(height: 20),

              // Botão de ajuda
              _buildHelpButton(context),

              const SizedBox(height: 20),

              // Botão para fechar
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o diálogo
                  },
                  child: const Text(
                    'Fechar',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar sliders com cores personalizadas
  Widget _buildSliderOption(
      String title, double currentValue, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.podkova(
            fontSize: 16,
            fontWeight: FontWeight.bold, // Fonte BOLD
            color: const Color(0xFF37ABDC), // Cor azul
          ),
        ),
        const SizedBox(height: 10), // Adicionado espaçamento antes do slider
        Slider(
          value: currentValue,
          min: 0,
          max: 1,
          divisions: 10,
          label: (currentValue * 100).toInt().toString(),
          onChanged: onChanged,
          activeColor: const Color(0xFFFCB44E), // Cor preenchida (bolinha)
          inactiveColor: const Color(0xFF37ABDC), // Parte não preenchida
          thumbColor: const Color(0xFFFCB44E), // Cor da bolinha do slider
        ),
      ],
    );
  }

  // Seletor de idioma com botões horizontais
  Widget _buildLanguageSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IDIOMA',
          style: GoogleFonts.podkova(
            fontSize: 16,
            fontWeight: FontWeight.bold, // Fonte BOLD
            color: const Color(0xFF37ABDC), // Cor azul
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLanguageButton('Português', 'Português'),
            const SizedBox(width: 10), // Espaçamento entre os botões
            _buildLanguageButton('Español', 'Espanhol'),
            const SizedBox(width: 10),
            _buildLanguageButton('English', 'Inglês'),
          ],
        ),
      ],
    );
  }

  // Função para criar botões de idioma personalizados
  Widget _buildLanguageButton(String language, String value) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedLanguage = value;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _selectedLanguage == value ? Colors.blue : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(
        language,
        style: GoogleFonts.podkova(
          fontSize: 14, // Reduzindo o tamanho da fonte dos idiomas
          fontWeight: FontWeight.bold,
          color: _selectedLanguage == value
              ? Colors.white
              : const Color(0xFFFCB44E),
        ),
      ),
    );
  }

  // Função para o botão de ajuda
  Widget _buildHelpButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        _showHelpDialog(context);
      },
      icon: const Icon(Icons.help_outline,
          color: Color(0xFFFEDE74)), // Cor amarela para o ícone de ajuda
      label: Text(
        'AJUDA',
        style: GoogleFonts.podkova(
          fontSize: 16,
          fontWeight: FontWeight.bold, // Fonte BOLD
          color: const Color(0xFF37ABDC), // Cor azul para o texto de ajuda
        ),
      ),
    );
  }

  // Diálogo de ajuda
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajuda'),
          content: const Text(
              'Aqui você pode ajustar as configurações de som, música, volume e selecionar o idioma da aplicação.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
