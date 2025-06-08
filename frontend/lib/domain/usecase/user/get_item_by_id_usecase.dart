import 'package:sharify_flutter_app/domain/entities/item_entity.dart';

import '../../repositories/item_repository.dart';

class GetItemByIdUseCase {
  final ItemRepository repository;

  GetItemByIdUseCase(this.repository);

  Future<ItemEntity?> execute(String id) async {
    return await repository.getItemById(id); // ✅ Fetch item details from SQLite
  }
}