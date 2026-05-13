import 'preferences_store.dart';

class ReadingProgressStore {
  ReadingProgressStore(this._store);

  static const _diabetesPageKey = 'book_diabetes_current_page';

  final PreferencesStore _store;

  Future<int> getDiabetesPage() {
    return _store.getInt(_diabetesPageKey, fallback: 0);
  }

  Future<void> setDiabetesPage(int pageIndex) {
    return _store.setInt(_diabetesPageKey, pageIndex);
  }
}
