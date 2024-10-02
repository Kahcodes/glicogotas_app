import 'package:flutter/material.dart';
import 'tela_inicial.dart'; 


void main() {
  runApp(const GlicogotasApp());
}

class GlicogotasApp extends StatelessWidget {
  const GlicogotasApp({Key? key}) : super(key: key); // Adicione o key aqui

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glicogotas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaInicial(), // Usando const para otimização
    );
  }
}
