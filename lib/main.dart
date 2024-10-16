import 'package:flutter/material.dart';
import 'Iniciar.dart';

void main() {
  runApp(const GlicogotasApp());
}

class GlicogotasApp extends StatelessWidget {
  const GlicogotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glicogotas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaInicial(),
    );
  }
}
