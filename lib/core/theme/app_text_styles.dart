import 'package:flutter/material.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const chewyFamily = 'Chewy';
  static const podkovaFamily = 'Podkova';
  static const sansitaSwashedFamily = 'Sansita Swashed';

  static TextStyle chewy({
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    List<Shadow>? shadows,
    Paint? foreground,
    TextDecoration? decoration,
    List<FontVariation>? fontVariations,
  }) {
    return _withFamily(
      chewyFamily,
      textStyle: textStyle,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      shadows: shadows,
      foreground: foreground,
      decoration: decoration,
      fontVariations: fontVariations,
    );
  }

  static TextStyle podkova({
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    List<Shadow>? shadows,
    Paint? foreground,
    TextDecoration? decoration,
    List<FontVariation>? fontVariations,
  }) {
    return _withFamily(
      podkovaFamily,
      textStyle: textStyle,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      shadows: shadows,
      foreground: foreground,
      decoration: decoration,
      fontVariations: fontVariations,
      useWeightAxis: true,
    );
  }

  static TextStyle sansitaSwashed({
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    List<Shadow>? shadows,
    Paint? foreground,
    TextDecoration? decoration,
    List<FontVariation>? fontVariations,
  }) {
    return _withFamily(
      sansitaSwashedFamily,
      textStyle: textStyle,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      shadows: shadows,
      foreground: foreground,
      decoration: decoration,
      fontVariations: fontVariations,
      useWeightAxis: true,
    );
  }

  static TextStyle _withFamily(
    String fontFamily, {
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    List<Shadow>? shadows,
    Paint? foreground,
    TextDecoration? decoration,
    List<FontVariation>? fontVariations,
    bool useWeightAxis = false,
  }) {
    final resolvedVariations = fontVariations ??
        (useWeightAxis && fontWeight != null
            ? [FontVariation('wght', fontWeight.value.toDouble())]
            : null);

    return (textStyle ?? const TextStyle()).copyWith(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      shadows: shadows,
      foreground: foreground,
      decoration: decoration,
      fontVariations: resolvedVariations,
    );
  }
}
