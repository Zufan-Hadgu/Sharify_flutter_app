import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


Future<void> saveJWT(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt_token', token);
  print("✅ JWT Token saved successfully: $token"); // 🔍 Debugging output
}

Future<String?> getJWT() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');
  print("🔄 Retrieved JWT Token: $token"); // 🔍 Debugging output
  return token;
}

Future<String?> getUserIdFromToken() async {
  final token = await getJWT();
  if (token != null && JwtDecoder.isExpired(token) == false) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      // Use 'id' instead of 'userId' to match your backend
      return decodedToken["id"]?.toString(); // Ensure it's a string
    } catch (e) {
      print('Error decoding JWT: $e');
      return null;
    }
  }
  return null;
}

