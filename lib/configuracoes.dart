import 'package:flutter/material.dart';

class ConfigDialog extends StatefulWidget {
  const ConfigDialog({super.key});

  @override
  _ConfigDialogState createState() => _ConfigDialogState();
}

class _ConfigDialogState extends State<ConfigDialog> {
  // Variáveis para armazenar o valor dos sliders
  double _somValue = 0.5;
  double _musicaValue = 0.5;
  double _volumeValue = 0.7;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Fundo transparente
      insetPadding: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          width: 300,
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
              const Text(
                'Configurações',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Controle de Som
              _buildSliderOption('Som', _somValue, (newValue) {
                setState(() {
                  _somValue = newValue;
                });
              }),

              // Controle de Música
              _buildSliderOption('Música', _musicaValue, (newValue) {
                setState(() {
                  _musicaValue = newValue;
                });
              }),

              // Controle de Volume
              _buildSliderOption('Volume', _volumeValue, (newValue) {
                setState(() {
                  _volumeValue = newValue;
                });
              }),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                child: const Text(
                  'Fechar',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar as opções de controle deslizante
  Widget _buildSliderOption(
      String title, double currentValue, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Slider(
          value: currentValue,
          min: 0,
          max: 1,
          divisions: 10, // Opcional, define os "passos" do slider
          label:
              (currentValue * 100).toInt().toString(), // Mostra o valor atual
          onChanged: onChanged,
        ),
      ],
    );
  }
}
