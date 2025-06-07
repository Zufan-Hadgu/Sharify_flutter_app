import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveJWT(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt_token', token);
}

Future<String?> getJWT() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');  // ✅ Centralized JWT retrieval
}