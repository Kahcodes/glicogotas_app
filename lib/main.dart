import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'iniciar.dart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Garante que o Flutter está inicializado
  await SharedPreferences.getInstance(); // Inicializa SharedPreferences
  runApp(const GlicogotasApp());
}

class GlicogotasApp extends StatelessWidget {
  const GlicogotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfiguracoesRepository()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690), // Tamanho de design base
        builder: (context, child) {
          return MaterialApp(
            home: const TelaInicial(),
            navigatorObservers: [
              routeObserver
            ], // Registra o RouteObserver aqui
          );
        },
      ),
    );
  }
}
