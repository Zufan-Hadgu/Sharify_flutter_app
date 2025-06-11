import 'package:dio/dio.dart';

import '../../entities/item_entity.dart';
import '../../repositories/admin_repository.dart';

class AdminAddItemUseCase {
  final AdminRepository repository;

  AdminAddItemUseCase(this.repository);

  Future<void> execute(ItemEntity item, MultipartFile image) async {
    await repository.addAdminItem(item, image);
  }
}