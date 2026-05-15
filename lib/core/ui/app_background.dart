import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgBackground extends StatelessWidget {
  const SvgBackground({
    super.key,
    required this.asset,
    this.fit = BoxFit.fill,
  });

  final String asset;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: RepaintBoundary(
        child: SvgPicture.asset(asset, fit: fit),
      ),
    );
  }
}
