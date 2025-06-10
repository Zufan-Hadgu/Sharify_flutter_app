import 'package:dio/dio.dart';
import '../../models/user_model.dart';

class AuthRemote {
  final Dio dio;

  AuthRemote(this.dio);

  Future<void> registerUser(UserModel user) async {
    try {
      final response = await dio.post("/api/auth/register", data: user.toMap());
    } catch (e) {
      print("API Error for registration: ${e.toString()}");
    }
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await dio.post(
        "/api/auth/login",
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {

        final userModel = UserModel.fromMap(response.data);

        return userModel;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  Future<bool> logout(String token) async {
    try {
      final response = await dio.post("/api/auth/logout");

      print("📌 Response Status Code: ${response.statusCode}");
      print("📌 Backend Response Data: ${response.data}");

      return response.statusCode == 200; // ✅ Returns true if successful
    } catch (e) {
      print("❌ API Error for logout: ${e.toString()}");
      return false; // ✅ Ensures a valid boolean return type on failure
    }
  }


  Future<bool> deleteAccount(String token) async {
    try {
      final response = await dio.delete(
        "/api/auth/delete-account",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      print("📌 Response Status Code: ${response.statusCode}");
      print("📌 Backend Response Data: ${response.data}");

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error deleting account: $e");
      return false;
    }
  }


}
