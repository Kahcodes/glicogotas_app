import 'package:flutter/widgets.dart';
import 'package:glicogotas_app/core/persistence/preferences_store.dart';
import 'package:glicogotas_app/core/persistence/reading_progress_store.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => PreferencesStore()),
        Provider(
          create: (context) => ReadingProgressStore(
            context.read<PreferencesStore>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsRepository(
            context.read<PreferencesStore>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
