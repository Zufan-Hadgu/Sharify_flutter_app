import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../domain/usecase/user/get_item_usecase.dart';
import 'item_state.dart';

class ItemNotifier extends StateNotifier<ItemState> {
  final GetItemsUseCase useCase;

  ItemNotifier(this.useCase) : super(ItemState.initial()) {
    print("🚀 ItemNotifier initialized!"); // ✅ Debugging
    loadItems();
  }

  Future<void> loadItems() async {
    state = ItemState.loading();

    try {
      final items = await useCase.execute();
      state = ItemState.success(items); // ✅ Use the correct factory method// ✅ Corrected from `ItemState.success`
    } catch (e) {
      print("❌ Error fetching items: $e"); // ✅ Debugging errors
      state = ItemState.error("Failed to load items");
    }
  }
}