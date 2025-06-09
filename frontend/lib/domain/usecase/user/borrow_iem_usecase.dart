import '../../repositories/item_repository.dart';

class BorrowItemUseCase {
  final ItemRepository repository;
  BorrowItemUseCase(this.repository);
  Future<void> execute(String itemId) async {
    await repository.borrowItem(itemId);
  }

}