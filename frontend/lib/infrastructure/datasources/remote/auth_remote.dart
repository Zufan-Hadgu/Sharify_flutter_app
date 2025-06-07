import 'package:dio/dio.dart';
import '../../models/user_model.dart';

class AuthRemote {
  final Dio dio;

  AuthRemote(this.dio);

  Future<void> registerUser(UserModel user) async {
    try {
      final response = await dio.post("/api/auth/register", data: user.toMap());
      print("Registration Response: ${response.data}");
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

      print("🔍 Full API Response: ${response.data}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        print("✅ API response is valid. Extracting token...");

        final userModel = UserModel.fromMap(response.data);
        print("🔹 Extracted UserModel: ${userModel.toMap()}");

        return userModel;
      }

      print("❌ API returned non-200 status code or missing success flag.");
      return null;
    } catch (e) {
      print("🔥 API Exception: ${e.toString()}");
      return null;
    }
  }
}
