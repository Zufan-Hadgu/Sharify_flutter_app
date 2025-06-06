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
      print("API Error for registration: ${e.toString()}"); // Debug output
    }
  }


  Future<UserModel?> login(String email, String password) async {
  try {
  final response = await dio.post(
  "/api/auth/login",
  data: {"email": email, "password": password},
  );

  if (response.statusCode == 200) {
    return UserModel.fromMap(response.data);
  }
   return null;
  } catch (e) {
      return null;
  }
      }
}
