import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlinedText extends StatelessWidget {
  const OutlinedText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.strokeColor = Colors.white,
    this.strokeWidth = 8,
    this.textAlign = TextAlign.center,
    this.shadows,
  });

  final String text;
  final double fontSize;
  final Color color;
  final Color strokeColor;
  final double strokeWidth;
  final TextAlign textAlign;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          textAlign: textAlign,
          style: GoogleFonts.chewy(
            fontSize: fontSize,
            shadows: shadows,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
          style: GoogleFonts.chewy(
            fontSize: fontSize,
            color: color,
          ),
        ),
      ],
    );
  }
}
