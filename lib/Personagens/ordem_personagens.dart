import 'package:flutter/material.dart';
import 'glicogotas.dart';
import 'lita.dart';
import 'srpancreas.dart';
import 'rei.dart';
import 'bobo.dart';
import 'fe.dart';
import 'insulins.dart';
import 'pumps.dart';
import 'betinho.dart';
import 'canetto.dart';

// Mude somente esta lista para reorganizar ou inserir personagens.
final List<Widget Function()> ordemPersonagens = [
  () => const PersonagensPage(),
  () => const PersonagemLitaPage(),
  () => const PersonagemSrPancreasPage(),
  () => const PersonagemReiPage(),
  () => const PersonagemBoboPage(),
  () => const PersonagemFePage(),
  () => const PersonagemInsulinsPage(),
  () => const PersonagemPumpsPage(),
  () => const PersonagemBetinhoPage(),
  () => const PersonagemCanettoPage(),
];

void navegarPersonagem(BuildContext context, Type atual, int direcao) {
  final indice = ordemPersonagens.indexWhere((criar) => criar().runtimeType == atual);
  if (indice < 0) return;
  final destino = indice + direcao;
  if (destino < 0 || destino >= ordemPersonagens.length) return;
  Navigator.of(context).pushReplacement(
    MaterialPageRoute<void>(builder: (_) => ordemPersonagens[destino]()),
  );
}
