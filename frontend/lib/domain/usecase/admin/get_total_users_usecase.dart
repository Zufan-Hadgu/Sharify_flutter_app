import '../../repositories/admin_repository.dart';

class GetTotalUsersUseCase {
  final AdminRepository repository;

  GetTotalUsersUseCase(this.repository);

  Future<int> call() => repository.getTotalUsers();
}
