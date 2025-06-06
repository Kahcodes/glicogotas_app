import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'iniciar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
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
        // Tamanho base mais compatível com tablets e celulares
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorObservers: [routeObserver],
            builder: (context, widget) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: widget ?? const SizedBox(),
              );
            },
            home: const TelaInicial(),
          );
        },
      ),
    );
  }
}
