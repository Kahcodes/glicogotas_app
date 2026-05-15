import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

void precacheLocalAsset(BuildContext context, String asset) {
  if (asset.isEmpty) return;

  if (asset.endsWith('.svg')) {
    SvgAssetLoader(asset).loadBytes(context);
    return;
  }

  precacheImage(AssetImage(asset), context);
}
