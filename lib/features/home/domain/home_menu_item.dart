import 'package:flutter/material.dart';

class HomeMenuItem {
  const HomeMenuItem({
    required this.label,
    required this.color,
    required this.icon,
    required this.routeName,
    required this.builder,
  });

  final String label;
  final Color color;
  final IconData icon;
  final String routeName;
  final WidgetBuilder builder;
}
