import '../../repositories/admin_repository.dart';

class DeleteItemUseCase {
  final AdminRepository repository;

  DeleteItemUseCase(this.repository);

  Future<void> execute(String itemId) async {
    print("📡 [UseCase] Executing delete for item: $itemId...");
    await repository.deleteItem(itemId);
  }
}