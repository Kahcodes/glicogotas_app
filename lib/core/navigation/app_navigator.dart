import 'package:flutter/material.dart';
import 'package:glicogotas_app/app/app_routes.dart';

abstract final class AppNavigator {
  static void goHome(BuildContext context) {
    Navigator.of(context).popUntil((route) {
      return route.settings.name == AppRoutes.home || route.isFirst;
    });
  }
}
