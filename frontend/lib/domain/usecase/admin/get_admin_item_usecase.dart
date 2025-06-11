
// usecases/get_items_usecase.dart
import '../../entities/item_entity.dart';
import '../../repositories/admin_repository.dart';
import '../../repositories/item_repository.dart';

class GetAdminItemsUseCase {
  final AdminRepository repository;
  GetAdminItemsUseCase(this.repository);

  Future<List<ItemEntity>> execute() async {

    final items = await repository.getAdminItems();

    return items;
  }
}