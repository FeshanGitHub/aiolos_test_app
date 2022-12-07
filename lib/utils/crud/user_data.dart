import 'package:shared_preferences/shared_preferences.dart';

Future setToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.remove('token');
}
