import 'package:flutter/material.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';
import 'iniciar.dart.dart';
import 'package:provider/provider.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
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
      child: MaterialApp(
        title: 'Glicogotas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TelaInicial(),
        navigatorObservers: [routeObserver], // Registra o RouteObserver aqui
      ),
    );
  }
}
