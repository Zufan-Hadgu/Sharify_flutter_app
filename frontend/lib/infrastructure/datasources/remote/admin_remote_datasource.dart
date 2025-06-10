import 'package:dio/dio.dart';

class AdminRemoteDataSource {
  final Dio dio;

  AdminRemoteDataSource(this.dio);
  Future<Map<String, int>> fetchDashboardStats() async {
    try {
      final response = await dio.get('api/admin/statistics');
      final data = response.data as Map<String, dynamic>;

      return {
        'totalUsers': data['totalUsers'] ?? 0,
        'availableItems': data['availableItems'] ?? 0,
      };
    } catch (e) {
      return {'totalUsers': 0, 'availableItems': 0};
    }
  }
}
