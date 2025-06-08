import 'package:sharify_flutter_app/domain/entities/item_entity.dart';

import '../../repositories/item_repository.dart';

class GetItemByIdUseCase {
  final ItemRepository repository;

  GetItemByIdUseCase(this.repository);

  Future<ItemEntity?> execute(String id) async {
    print("📥 [UseCase] execute() called with ID: $id");

    try {
      print("🔍 [UseCase] Calling repository...");
      final result = await repository.getItemById(id);
      print("📤 [UseCase] Repository returned: $result");

      return result;
    } catch (e) {
      print("❌ [UseCase] Error: $e"); // ✅ Catch errors
      return null;
    }
  }

}