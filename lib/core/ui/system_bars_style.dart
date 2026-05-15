import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemBarsStyle extends StatelessWidget {
  const SystemBarsStyle({
    super.key,
    required this.statusBarColor,
    required this.navigationBarColor,
    required this.child,
    this.statusBarIconBrightness,
    this.navigationBarIconBrightness,
  });

  const SystemBarsStyle.transparent({
    super.key,
    required this.child,
    this.statusBarIconBrightness = Brightness.dark,
    this.navigationBarIconBrightness = Brightness.dark,
  })  : statusBarColor = Colors.transparent,
        navigationBarColor = Colors.transparent;

  final Color statusBarColor;
  final Color navigationBarColor;
  final Brightness? statusBarIconBrightness;
  final Brightness? navigationBarIconBrightness;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final statusIcons =
        statusBarIconBrightness ?? _iconBrightnessFor(statusBarColor);
    final navigationIcons =
        navigationBarIconBrightness ?? _iconBrightnessFor(navigationBarColor);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusIcons,
        statusBarBrightness: statusIcons == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarDividerColor: navigationBarColor,
        systemNavigationBarIconBrightness: navigationIcons,
        systemNavigationBarContrastEnforced: false,
      ),
      child: child,
    );
  }

  static Brightness _iconBrightnessFor(Color color) {
    return color.computeLuminance() < 0.45 ? Brightness.light : Brightness.dark;
  }
}
