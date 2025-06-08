import 'package:sharify_flutter_app/domain/repositories/item_repository.dart';
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
      for (var item in items) {
        print("🛠 Mapping ItemModel to ItemEntity: ${item.toJson()}");
      }

      final entityItems = items.map((e) => e.toEntity()).toList();
      print("🎯 Final Mapped Entity Count: ${entityItems.length}");

      await localDataSource.cacheItems(items);
      print("💾 Cached items successfully!");

      return entityItems;
    } catch (error) {
      print("🔄 Trying to retrieve cached items...");
      final local = await localDataSource.getCachedItems();
      return local.map((e) => e.toEntity()).toList();
    }
  }

  Future<ItemEntity?> getItemById(String id) async {
    print("🔍 [Repository] Searching for item ID in local storage: $id");

    try {
      final localItem = await localDataSource.getItemById(id);
      if (localItem != null) {
        print("✅ [Repository] Found in Local Storage: ${localItem.name}");
        return localItem.toEntity(); // ✅ Returns the item from local storage
      }

      print("❌ [Repository] No Item Found in Local Storage.");
      return null;
    } catch (e) {
      print("❌ [Repository] Error: $e");
      return null;
    }
  }




}