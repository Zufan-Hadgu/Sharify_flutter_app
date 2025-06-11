import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/errors/failures.dart';
import '../entities/dashboard_stats_entity.dart';
import '../entities/item_entity.dart';

abstract class AdminRepository {
  Future<int> getTotalUsers();
  Future<int> getTotalItems();
  Future<void> addAdminItem(ItemEntity item, MultipartFile image);
  Future<List<ItemEntity>> getAdminItems();
  Future<void> updateItem({
    required String itemId,
    required ItemEntity item,
    required MultipartFile? image, // ✅ Uses MultipartFile for image upload
  });
  Future<void> deleteItem(String itemId);


}


