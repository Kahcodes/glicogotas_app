import 'package:flutter/material.dart';

/// Reutiliza o menu existente e remove as páginas abertas acima dele.
/// Se o menu não estiver na pilha, substitui a rota restante pelo destino.
void voltarAoMenu(BuildContext context, String nome, Widget destino) {
  final navigator = Navigator.of(context);
  var encontrado = false;
  navigator.popUntil((route) {
    encontrado = route.settings.name == nome;
    return encontrado || route.isFirst;
  });
  if (!encontrado) {
    navigator.pushReplacement(
      MaterialPageRoute<void>(
        settings: RouteSettings(name: nome),
        builder: (_) => destino,
      ),
    );
  }
}
