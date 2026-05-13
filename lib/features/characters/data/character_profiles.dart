import 'package:flutter/material.dart';
import 'package:glicogotas_app/features/characters/domain/character_profile.dart';

const characterProfiles = [
  CharacterProfile(
    name: 'Lita',
    description: 'É uma super-heroína que enfrenta o DM1 em grandes aventuras!',
    audioAsset: 'audio/audioPersonagens/lita.mp3',
    backgroundAsset: 'assets/images/fundo-lita.svg',
    orbitAsset: 'assets/images/lita-person.svg',
    characterAsset: 'assets/images/Lita-heroina.svg',
    color: Color(0xFFF4719C),
    characterTopFactor: 0.26,
    characterHeightFactor: 0.42,
  ),
  CharacterProfile(
    name: 'Rei da Hiper',
    description:
        'O Rei da Hiper se forma quando o açúcar está elevado. É hora de cuidar do equilíbrio do corpo!',
    audioAsset: 'audio/audioPersonagens/hiper.mp3',
    backgroundAsset: 'assets/images/fundo-rei.svg',
    orbitAsset: 'assets/images/eclipse-rei.svg',
    characterAsset: 'assets/images/rei-da-hiper.svg',
    color: Color(0xFFEF291D),
    characterTopFactor: 0.22,
    characterHeightFactor: 0.50,
  ),
  CharacterProfile(
    name: 'Bobo da Hipo',
    description:
        'O Bobo da Hipo aparece quando o açúcar está baixo e nos faz entrar em muita confusão!',
    audioAsset: 'audio/audioPersonagens/bobo.mp3',
    backgroundAsset: 'assets/images/fundo-bobo.svg',
    orbitAsset: 'assets/images/eclipse-bobo.svg',
    characterAsset: 'assets/images/bobo-person.svg',
    color: Color(0xFF00D287),
    characterTopFactor: 0.29,
  ),
  CharacterProfile(
    name: 'Fê',
    description:
        'É a fitinha que mede o açúcar no sangue, ajudando no monitoramento e nas metas exemplares!',
    audioAsset: 'audio/audioPersonagens/fe.mp3',
    backgroundAsset: 'assets/images/fundo-fe.svg',
    orbitAsset: 'assets/images/eclipse-fe.svg',
    characterAsset: 'assets/images/fe-person.svg',
    color: Color(0xFF37ABDC),
  ),
  CharacterProfile(
    name: 'Insulins',
    description:
        'Esses são Lento e Rápido, juntos eles controlam o diabetes da Lita!',
    audioAsset: 'audio/audioPersonagens/insulins.mp3',
    backgroundAsset: 'assets/images/fundo-insulins.svg',
    orbitAsset: 'assets/images/eclipse-insulins.svg',
    characterAsset: 'assets/images/insulins-person.svg',
    color: Color(0xFFFCB44E),
  ),
  CharacterProfile(
    name: 'Pumps',
    description:
        'É a bombinha de insulina que regula o açúcar no sangue e avisa quando precisa de atenção!',
    audioAsset: 'audio/audioPersonagens/pumps.mp3',
    backgroundAsset: 'assets/images/fundo-pumps.svg',
    orbitAsset: 'assets/images/eclipse-pumps.svg',
    characterAsset: 'assets/images/pumps-person.svg',
    color: Color(0xFFD91B91),
    descriptionBottomFactor: 0.18,
  ),
  CharacterProfile(
    name: 'Betinho',
    description:
        'É o monitor de glicemia, sempre atento para manter a Lita segura!',
    audioAsset: 'audio/audioPersonagens/betinho.mp3',
    backgroundAsset: 'assets/images/fundo-betinho.svg',
    orbitAsset: 'assets/images/eclipse-betinho.svg',
    characterAsset: 'assets/images/betinho-person.svg',
    color: Color(0xFF01C881),
    characterTopFactor: 0.28,
  ),
  CharacterProfile(
    name: 'Canetto',
    description:
        'O Canetto aparece com precisão e cuidado para aplicar a insulina quando a Pumps precisa de ajuda!',
    audioAsset: 'audio/audioPersonagens/canetto.mp3',
    backgroundAsset: 'assets/images/fundo-canetto.svg',
    orbitAsset: 'assets/images/eclipse-canetto.svg',
    characterAsset: 'assets/images/perso-canetto.svg',
    color: Color(0xFF071A51),
    characterTopFactor: 0.28,
  ),
];
