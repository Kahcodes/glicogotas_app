import 'package:flutter/material.dart';
import 'tela_opcoes.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glicogotas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Adicione a logo aqui
            Image.asset(
              'assets/images/glicogotas_logo.png',
              height: 400, // Ajuste a altura conforme necessário
            ),
            const SizedBox(height: 20), // Espaçamento entre a logo e o texto
            const Text(
              'Desvendando o Diabetes',
              style: TextStyle(fontSize: 24), // Ajuste o estilo conforme necessário
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaOpcoes()),
                );
              },
              child: const Text('Iniciar'),
            ),
          ],
        ),
      ),
    );
  }
}
