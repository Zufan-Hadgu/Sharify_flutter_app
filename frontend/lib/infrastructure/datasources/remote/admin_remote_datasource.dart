import '../../../core/network/api_provider.dart';

class AdminRemoteDataSource {
  final ApiProvider api;

  AdminRemoteDataSource(this.api);

  Future<int> fetchTotalUsers() async {
    final response = await api.get('/admin/statistics');
    return (response['statistics']?['totalUsers'] ?? 0) as int;
  }

  Future<int> fetchTotalItems() async {
    final response = await api.get('/admin/statistics');
    return (response['statistics']?['availableItems'] ?? 0) as int;
  }
}
