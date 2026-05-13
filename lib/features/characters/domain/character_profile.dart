import 'package:flutter/material.dart';

class CharacterProfile {
  const CharacterProfile({
    required this.name,
    required this.description,
    required this.audioAsset,
    required this.backgroundAsset,
    required this.orbitAsset,
    required this.characterAsset,
    required this.color,
    this.characterTopFactor = 0.26,
    this.characterHeightFactor = 0.38,
    this.descriptionBottomFactor = 0.20,
  });

  final String name;
  final String description;
  final String audioAsset;
  final String backgroundAsset;
  final String orbitAsset;
  final String characterAsset;
  final Color color;
  final double characterTopFactor;
  final double characterHeightFactor;
  final double descriptionBottomFactor;
}
