import 'package:sharify_flutter_app/domain/entities/item_entity.dart';

import '../../repositories/item_repository.dart';


class GetBorrowedItemsUseCase {
  final ItemRepository repository;

  GetBorrowedItemsUseCase(this.repository);

  Future<List<ItemEntity>> execute(String userId) async {
    print("🔍 Fetching borrowed items for userId: $userId"); // ✅ Debugging step

    final borrowedItems = await repository.getBorrowedItems(userId);

    print("📂 Borrowed Items Retrieved: ${borrowedItems.length}");
    for (var item in borrowedItems) {
      print("🛒 Item: ${item.name}, ID: ${item.id}");
    }

    return borrowedItems;
  }
}