import 'package:glicogotas_app/core/persistence/preferences_store.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';

class ConfiguracoesRepository extends SettingsRepository {
  ConfiguracoesRepository() : super(PreferencesStore());

  Future<bool> getSoundOn() async => soundOn;

  Future<bool> getMusicOn() async => musicOn;

  Future<double> getVolume() async => volume;

  Future<String> getLanguage() async => 'Português';

  Future<void> setLanguage(String lang) async {}
}
