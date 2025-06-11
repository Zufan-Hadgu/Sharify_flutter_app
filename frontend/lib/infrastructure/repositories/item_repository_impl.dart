import 'package:sharify_flutter_app/domain/repositories/item_repository.dart';
import '../../core/utils/SaveJWT.dart';
import '../../domain/entities/item_entity.dart';
import '../datasources/local/item_local.dart';
import '../datasources/remote/item_remote.dart';
import '../models/Item_model.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemLocalDataSource localDataSource;
  final ItemRemoteDataSource remoteDataSource;

  ItemRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<List<ItemEntity>> getItems() async {
    try {
      final items = await remoteDataSource.fetchItems();
      final entityItems = items.map((e) => e.toEntity()).toList();
      await localDataSource.cacheItems(items);
      return entityItems;
    } catch (e) {
      print("❌ [LocalStorage] Fetching cached items due to error: $e");
      final local = await localDataSource.getCachedItems();
      return local.isNotEmpty
          ? local.map((e) => e.toEntity()).toList()
          : throw Exception("❌ No cached items available");
    }
  }
  @override
  Future<ItemEntity?> getItemById(String id) async {
    final item = await localDataSource.getItemById(id);
    print("🛠️ [Repository] Found Item: $item"); // ✅ Log output
    return item?.toEntity(); // ✅ Ensure conversion to ItemEntity
  }
  Future<bool> borrowItem(String itemId) async {
    try {
      print("🔄 Starting borrow process for item: $itemId");

      final token = await getJWT();
      if (token == null) {
        return false;  // ✅ Explicitly returning false instead of throwing
      }

      final success = await remoteDataSource.borrowItem(itemId, token);
      return success;  // ✅ Ensure a return value

    } catch (error) {
      return false;  // ✅ Return false in error cases
    }
  }

  @override
  Future<List<ItemEntity>> getBorrowedItems(String userId) async {
    final items = await remoteDataSource.fetchBorrowedItems();
    return items.map((item) => item.toEntity()).toList();
  }

  Future<bool> updateNote(String itemId, String note) async {
    try {
      final token = await getJWT();
      if (token == null) return false;

      return await remoteDataSource.updateNote(itemId, note, token);
    } catch (_) {
      return false;
    }
  }

  Future<bool> removeBorrowedItem(String itemId) async {
    try {
      final token = await getJWT(); // ✅ Retrieve stored authentication token
      if (token == null) return false;

      return await remoteDataSource.removeBorrowedItem(itemId, token);
    } catch (e) {
      print("❌ Error removing borrowed item: $e");
      return false;
    }
  }



}