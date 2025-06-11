import 'package:dio/dio.dart';

import '../../entities/item_entity.dart';
import '../../repositories/admin_repository.dart';

class UpdateItemUseCase {
  final AdminRepository _repository;

  UpdateItemUseCase(this._repository);

  Future<void> execute(String itemId, ItemEntity item, MultipartFile? image) async {
    print("📡 [UseCase] Executing update for item: $itemId...");
    await _repository.updateItem(itemId: itemId, item: item, image: image);
  }
}