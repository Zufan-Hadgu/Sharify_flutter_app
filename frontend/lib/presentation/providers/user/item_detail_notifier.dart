import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/provider/item_provider.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../domain/usecase/user/get_item_by_id_usecase.dart';

class ItemDetailNotifier extends StateNotifier<ItemEntity?> {
  final GetItemByIdUseCase getItemByIdUseCase;

  ItemDetailNotifier(this.getItemByIdUseCase) : super(null);

  Future<void> fetchItemDetails(String id) async {
    state = await getItemByIdUseCase.execute(id); // ✅ Fetch item details
  }
}

final itemDetailNotifierProvider = StateNotifierProvider<ItemDetailNotifier, ItemEntity?>(
      (ref) => ItemDetailNotifier(ref.read(getItemByIdUseCaseProvider)),
);