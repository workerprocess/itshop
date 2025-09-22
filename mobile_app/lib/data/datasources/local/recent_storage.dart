import 'package:shared_preferences/shared_preferences.dart';

class RecentStorage {
  static const String _key = 'recent_viewed_product_ids';
  static const int _maxItems = 10;

  Future<List<String>> getRecentIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? <String>[];
  }

  Future<void> addRecentId(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? <String>[];

    // Move to front, ensure uniqueness, and cap size
    list.remove(productId);
    list.insert(0, productId);
    if (list.length > _maxItems) {
      list.removeRange(_maxItems, list.length);
    }

    await prefs.setStringList(_key, list);
  }
}


