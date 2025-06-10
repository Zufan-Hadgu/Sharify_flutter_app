import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:sharify_flutter_app/core/network/dio_client.dart';

void main() {
  late DioClient dioClient;

  setUp(() {
    dioClient = DioClient();
  });

  test('DioClient should provide a Dio instance with correct baseUrl', () {
    final dio = dioClient.dio;
    expect(dio, isA<Dio>());
    expect(dio.options.baseUrl, equals("http://10.0.2.2:4000"));
  });

  test('DioClient Dio instance should have correct headers', () {
    final dio = dioClient.dio;
    expect(dio.options.headers["Content-Type"], equals("application/json"));
  });

  test('DioClient Dio instance should have timeouts set', () {
    final dio = dioClient.dio;
    expect(dio.options.connectTimeout, equals(const Duration(seconds: 10)));
    expect(dio.options.receiveTimeout, equals(const Duration(seconds: 10)));
  });
}
