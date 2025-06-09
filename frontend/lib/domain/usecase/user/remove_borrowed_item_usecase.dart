import '../../repositories/item_repository.dart';


class RemoveBorrowedItemUseCase {
  final ItemRepository itemRepository;

  RemoveBorrowedItemUseCase(this.itemRepository);

  Future<bool> execute(String itemId) async {
    return await itemRepository.removeBorrowedItem(itemId);
  }
}