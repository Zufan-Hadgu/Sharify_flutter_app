import '../../infrastructure/models/Item_model.dart';
import '../entities/item_entity.dart';
abstract class ItemRepository {
  Future<List<ItemEntity>> getItems();
  Future<ItemEntity?> getItemById(String id);
  Future<void> borrowItem(String itemId);
  Future<List<ItemEntity>> getBorrowedItems(String userId);
  Future<bool> updateNote(String itemId, String note);
  Future<bool> removeBorrowedItem(String itemId);





}