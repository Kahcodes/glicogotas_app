import 'package:flutter/material.dart';
import 'package:glicogotas_app/app/glicogotas_app.dart';

export 'package:glicogotas_app/app/glicogotas_app.dart';
export 'package:glicogotas_app/app/route_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GlicogotasApp());
}
