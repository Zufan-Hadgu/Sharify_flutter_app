import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://10.0.2.2:4000",
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {
      "Content-Type": "application/json",
    },
  ));

  Dio get dio => _dio;
}