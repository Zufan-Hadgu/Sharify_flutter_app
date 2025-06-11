import '../../repositories/admin_repository.dart';

class GetTotalUsersUseCase {
  final AdminRepository repository;

  GetTotalUsersUseCase(this.repository);

  Future<int> execute() async {
    return await repository.getTotalUsers();
  }
}