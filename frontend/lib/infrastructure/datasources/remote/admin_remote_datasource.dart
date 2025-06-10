import 'package:dio/dio.dart';

class AdminRemoteDataSource {
  final Dio dio;

  AdminRemoteDataSource(this.dio);

  Future<Map<String, int>> fetchDashboardStats() async {
    try {

      final response = await dio.get('/api/admin/statistics');
      final data = response.data as Map<String, dynamic>;
      final totalUsers = data['totalUsers'] ?? 0;
      final availableItems = data['availableItems'] ?? 0;
      return {
        'totalUsers': totalUsers,
        'availableItems': availableItems,
      };
    } catch (e, stackTrace) {
      return {'totalUsers': 0, 'availableItems': 0};
    }
  }
}