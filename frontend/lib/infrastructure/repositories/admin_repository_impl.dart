import '../../domain/repositories/admin_repository.dart';
import '../datasources/remote/admin_remote_datasource.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl(this.remoteDataSource);

  @override
  Future<int> getTotalUsers() async {
    final stats = await remoteDataSource.fetchDashboardStats();
    return stats['totalUsers'] ?? 0;
  }

  @override
  Future<int> getTotalItems() async {
    final stats = await remoteDataSource.fetchDashboardStats();
    return stats['availableItems'] ?? 0;
  }
}