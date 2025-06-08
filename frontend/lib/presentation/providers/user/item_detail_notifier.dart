import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/provider/item_provider.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../domain/usecase/user/get_item_by_id_usecase.dart';

class ItemDetailNotifier extends StateNotifier<ItemEntity?> {
  final GetItemByIdUseCase getItemByIdUseCase;

  ItemDetailNotifier(this.getItemByIdUseCase) : super(null);

  Future<void> fetchItemDetails(String id) async {
    print("🔍 Fetching Item Details for ID: $id");
    state = null;

    print("📥 [Notifier] Calling use case...");
    final result = await getItemByIdUseCase.execute(id); // ✅ This might be failing

    print("📤 [Notifier] Use case returned: $result"); // ✅ Log output

    state = result;
  }
}

final itemDetailNotifierProvider = StateNotifierProvider<ItemDetailNotifier, ItemEntity?>(
      (ref) {
    print("✅ Creating ItemDetailNotifier"); // ✅ Debugging
    return ItemDetailNotifier(ref.watch(getItemByIdUseCaseProvider));
  },
);