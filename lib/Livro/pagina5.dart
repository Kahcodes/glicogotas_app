import 'package:flutter/material.dart';

class Pagina5Page extends StatelessWidget {
  const Pagina5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página 5'),
        backgroundColor: const Color(0xFF265F95),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navega de volta para a Página 4
            Navigator.pop(context);
          },
          child: const Text('Voltar para a Página 4'),
        ),
      ),
    );
  }
}
