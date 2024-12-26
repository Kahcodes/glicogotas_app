import 'package:flutter/material.dart';
import 'package:glicogotas_app/controleaudio.dart';

class MusicRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final AudioManager audioManager;

  MusicRouteObserver(this.audioManager);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null && previousRoute.settings.name == '/home') {
      audioManager.stop();
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == '/home') {
      audioManager.play('audio/musica.mp3', route.navigator!.context);
    }
  }
}
