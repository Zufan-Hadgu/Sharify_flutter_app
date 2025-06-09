import '../../repositories/admin_repository.dart';

class GetTotalItemsUseCase {
  final AdminRepository repository;

  GetTotalItemsUseCase(this.repository);

  Future<int> call() => repository.getTotalItems();
}
