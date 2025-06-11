// import 'package:dio/dio.dart';
// import '../../domain/repositories/admin_repository.dart';
// import '../../domain/entities/item_entity.dart';
// import '../datasources/remote/admin_remote_datasource.dart';
//
// class AdminRepositoryImpl implements AdminRepository {
//   final AdminRemoteDataSource remoteDataSource;
//
//   AdminRepositoryImpl(this.remoteDataSource);
//
//   /// ✅ Fetch Total Users
//   @override
//   Future<int> getTotalUsers() async {
//     final stats = await remoteDataSource.fetchDashboardStats();
//     return stats['totalUsers'] ?? 0;
//   }
//
//   /// ✅ Fetch Total Items
//   @override
//   Future<int> getTotalItems() async {
//     final stats = await remoteDataSource.fetchDashboardStats();
//     return stats['availableItems'] ?? 0;
//   }
//
//   /// ✅ Add Admin Item
//   @override
//   Future<void> addAdminItem(ItemEntity item, MultipartFile image) async {
//     await remoteDataSource.addAdminItem(item, image);
//   }
//
//   Future<List<ItemEntity>> getAdminItems() async {
//     print("📡 [AdminRepository] Fetching admin items...");
//
//     final models = await remoteDataSource.fetchAdminItems();
//
//     if (models.isEmpty) {
//       print("⚠️ [AdminRepository] API returned an empty item list!");
//     } else {
//       print("✅ [AdminRepository] Converting ${models.length} models to entities...");
//     }
//
//     return models.map((model) => model.toEntity()).toList();
//   }
// }


import 'package:dio/dio.dart';
import '../../domain/repositories/admin_repository.dart';
import '../../domain/entities/item_entity.dart';
import '../datasources/remote/admin_remote_datasource.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl(this.remoteDataSource);

  /// ✅ Fetch Total Users
  @override
  Future<int> getTotalUsers() async {
    final stats = await remoteDataSource.fetchDashboardStats();
    return stats['totalUsers'] ?? 0;
  }

  /// ✅ Fetch Total Items
  @override
  Future<int> getTotalItems() async {
    final stats = await remoteDataSource.fetchDashboardStats();
    return stats['availableItems'] ?? 0;
  }

  /// ✅ Add Admin Item
  @override
  Future<void> addAdminItem(ItemEntity item, MultipartFile image) async {
    await remoteDataSource.addAdminItem(item, image);
  }

  Future<List<ItemEntity>> getAdminItems() async {
    print("📡 [AdminRepository] Fetching admin items...");

    final models = await remoteDataSource.fetchAdminItems();

    if (models.isEmpty) {
      print("⚠️ [AdminRepository] API returned an empty item list!");
    } else {
      print("✅ [AdminRepository] Converting ${models.length} models to entities...");
    }

    return models.map((model) => model.toEntity()).toList();
  }


  Future<void> updateItem({
    required String itemId,
    required ItemEntity item,
    required MultipartFile? image,
  }) async {
    print("📡 [Repository] Calling RemoteDataSource for item update...");
    await remoteDataSource.updateItem(itemId: itemId, item: item, image: image);
  }
  @override
  Future<void> deleteItem(String itemId) async {
    print("📡 [RepositoryImpl] Calling RemoteDataSource for item deletion...");
    await remoteDataSource.deleteItem(itemId);
  }

}

