import 'package:shared_preferences/shared_preferences.dart';

class PageService {
  static const String _key = 'current_page';

  // Salva o número da página atual
  Future<void> saveCurrentPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, page);
    // print('Página salva: $page'); // Removido o print
  }

  // Carrega o número da página salva (retorna 1 se não houver)
  Future<int> loadCurrentPage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 1; // Removido o print
  }
}
