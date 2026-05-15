import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/ui/outlined_text.dart';
import 'package:glicogotas_app/features/characters/domain/character_profile.dart';

class CharacterDetailPage extends StatelessWidget {
  const CharacterDetailPage({
    super.key,
    required this.profile,
  });

  final CharacterProfile profile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0.15.sh,
          left: 0,
          right: 0,
          child: OutlinedText(
            text: profile.name,
            fontSize: 0.13.sw,
            color: profile.color,
            strokeWidth: 8,
            shadows: [
              Shadow(
                color: Colors.black.withAlpha((0.25 * 255).toInt()),
                offset: const Offset(3, 3),
                blurRadius: 5,
              ),
            ],
          ),
        ),
        Positioned(
          top: 0.28.sh,
          left: 0,
          right: 0,
          child: Center(
            child: RepaintBoundary(
              child: SvgPicture.asset(
                profile.orbitAsset,
                height: 0.36.sh,
              ),
            ),
          ),
        ),
        Positioned(
          top: profile.characterTopFactor.sh,
          left: 0,
          right: 0,
          child: Center(
            child: RepaintBoundary(
              child: SvgPicture.asset(
                profile.characterAsset,
                height: profile.characterHeightFactor.sh,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: profile.descriptionBottomFactor.sh,
          left: 20.w,
          right: 20.w,
          child: OutlinedText(
            text: profile.description,
            fontSize: 0.06.sw,
            color: profile.color,
            strokeWidth: 8,
            shadows: [
              Shadow(
                color: Colors.black.withAlpha((0.25 * 255).toInt()),
                offset: const Offset(3, 3),
                blurRadius: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
