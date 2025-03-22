import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _tokenKey = 'auth_token';

  /// everything about token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  /// everything about book
  Future<void> saveAdditionalBook(List<String> bookId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('additional_book_id', bookId);
  }

  Future<List<String>?> getAdditionalBookId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('additional_book_id');
  }

  Future<void> removeBookId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('additional_book_id');
  }

  /// everything about role
  Future<void> saveUserRole(String roleid) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_role', roleid);
  }

  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
  }

  Future<void> removeUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_role');
  }
}
