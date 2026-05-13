import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/app/app_providers.dart';
import 'package:glicogotas_app/app/route_observer.dart';
import 'package:glicogotas_app/features/startup/presentation/start_page.dart';

class GlicogotasApp extends StatelessWidget {
  const GlicogotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: ScreenUtilInit(
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
            home: const StartPage(),
          );
        },
      ),
    );
  }
}
