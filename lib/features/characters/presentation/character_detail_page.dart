import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glicogotas_app/core/ui/config_dialog.dart';
import 'package:glicogotas_app/core/ui/outlined_text.dart';
import 'package:glicogotas_app/features/characters/domain/character_profile.dart';

class CharacterDetailPage extends StatelessWidget {
  const CharacterDetailPage({
    super.key,
    required this.profile,
    required this.onHome,
  });

  final CharacterProfile profile;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(
          context,
          designSize: const Size(360, 690),
          minTextAdapt: true,
        );

        return Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                profile.backgroundAsset,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 40.h,
              left: 16.w,
              child: IconButton(
                iconSize: 30.sp,
                icon: const Icon(
                  Icons.home_rounded,
                  color: Color.fromARGB(255, 0, 132, 255),
                ),
                onPressed: onHome,
              ),
            ),
            Positioned(
              top: 40.h,
              right: 16.w,
              child: IconButton(
                iconSize: 30.sp,
                icon: const Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 0, 132, 255),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const ConfigDialog(),
                  );
                },
              ),
            ),
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
                child: SvgPicture.asset(
                  profile.orbitAsset,
                  height: 0.36.sh,
                ),
              ),
            ),
            Positioned(
              top: profile.characterTopFactor.sh,
              left: 0,
              right: 0,
              child: Center(
                child: SvgPicture.asset(
                  profile.characterAsset,
                  height: profile.characterHeightFactor.sh,
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
      },
    );
  }
}
