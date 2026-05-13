import 'package:flutter/material.dart';

enum BookLayerType { svg, image }

class BookVisualLayer {
  const BookVisualLayer({
    required this.asset,
    required this.type,
    this.topFactor,
    this.bottomFactor,
    this.leftFactor,
    this.rightFactor,
    this.widthFactor,
    this.heightFactor,
    this.fit = BoxFit.contain,
  });

  final String asset;
  final BookLayerType type;
  final double? topFactor;
  final double? bottomFactor;
  final double? leftFactor;
  final double? rightFactor;
  final double? widthFactor;
  final double? heightFactor;
  final BoxFit fit;
}

class BookPageContent {
  const BookPageContent({
    required this.audioAsset,
    required this.backgroundAsset,
    required this.layers,
    this.isCover = false,
    this.backgroundColor = Colors.white,
  });

  final String audioAsset;
  final String backgroundAsset;
  final List<BookVisualLayer> layers;
  final bool isCover;
  final Color backgroundColor;
}
