import '../../domain/repositories/admin_repository.dart';
import '../datasources/remote/admin_remote_datasource.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl(this.remoteDataSource);

  @override
  Future<int> getTotalUsers() => remoteDataSource.fetchTotalUsers();

  @override
  Future<int> getTotalItems() => remoteDataSource.fetchTotalItems();
}
