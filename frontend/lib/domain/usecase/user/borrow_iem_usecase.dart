import '../../repositories/item_repository.dart';

class BorrowItemUseCase {
  final ItemRepository repository;

  BorrowItemUseCase(this.repository);

  Future<bool> execute(String itemId) async {
    try {
      return await repository.borrowItem(itemId);  // ✅ Ensure return value
    } catch (error) {
      return false;  // ✅ Explicit return in case of failure
    }
  }
}