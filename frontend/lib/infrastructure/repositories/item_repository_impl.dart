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
    } catch (_) {
      final local = await localDataSource.getCachedItems();
      return local.map((e) => e.toEntity()).toList();
    }
  }

  Future<ItemEntity?> getItemById(String id) async {
    try {
      final localItem = await localDataSource.getItemById(id);
      return localItem?.toEntity();
    } catch (_) {
      return null;
    }
  }

  Future<void> borrowItem(String itemId) async {
    try {
      final token = await getJWT();
      if (token == null) throw Exception("User authentication required.");

      final userId = await getUserIdFromToken();
      if (userId == null) throw Exception("User authentication failed.");

      final item = await localDataSource.getItemById(itemId);
      if (item == null) throw Exception("Item not available locally.");

      final success = await remoteDataSource.borrowItem(itemId, token);
      if (!success) throw Exception("Failed to update borrowing status.");

      await localDataSource.borrowItemLocally(itemId, userId);
    } catch (_) {}
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

}