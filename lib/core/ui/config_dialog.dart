import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';
import 'package:glicogotas_app/sobre_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConfigDialog extends StatelessWidget {
  const ConfigDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsRepository>();

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10.w),
        child: GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              width: 300.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF008AD7),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.3 * 255).toInt()),
                    blurRadius: 10.r,
                    offset: Offset(0, 5.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFFFEDE74),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'CONFIGURAÇÕES',
                            style: GoogleFonts.chewy(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFCB44E),
                              shadows: [
                                Shadow(
                                  color: Colors.black
                                      .withAlpha((0.5 * 255).toInt()),
                                  offset: Offset(2.w, 2.h),
                                  blurRadius: 4.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48.w),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _SwitchOption(
                    title: 'SOM',
                    value: settings.musicOn,
                    onChanged: (_) => settings.switchMusicOn(),
                  ),
                  SizedBox(height: 20.h),
                  const Divider(color: Colors.white70),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SOBRE',
                        style: GoogleFonts.podkova(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color:
                                  Colors.black.withAlpha((0.5 * 255).toInt()),
                              offset: Offset(2.w, 2.h),
                              blurRadius: 4.r,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SobrePage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.help_outline,
                          color: Color(0xFFFEDE74),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchOption extends StatelessWidget {
  const _SwitchOption({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                value ? Icons.volume_up : Icons.volume_off,
                color: const Color(0xFFFCB44E),
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.chewy(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      offset: Offset(2.w, 2.h),
                      blurRadius: 4.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            activeThumbColor: const Color(0xFFFCB44E),
            inactiveTrackColor: Colors.white,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
