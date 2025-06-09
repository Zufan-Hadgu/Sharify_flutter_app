import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharify_flutter_app/domain/usecase/user/get_borrowed_item_usecase.dart';
import '../../../core/utils/SaveJWT.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../domain/usecase/user/borrow_iem_usecase.dart';
import '../../../domain/usecase/user/get_item_usecase.dart';
import '../../../domain/usecase/user/update_note_use_case.dart';
import 'item_state.dart';

class ItemNotifier extends StateNotifier<ItemState> {
  final GetItemsUseCase useCase;
  final BorrowItemUseCase borrowItemUseCase;
  final GetBorrowedItemsUseCase getBorrowedItemsUseCase;
  final UpdateNoteUseCase updateNoteUseCase;


  ItemNotifier(this.useCase, this.borrowItemUseCase,
      this.getBorrowedItemsUseCase, this.updateNoteUseCase)
      : super(ItemState.initial()) {
    loadItems();
  }

  Future<void> loadItems() async {
    state = ItemState.loading();

    try {
      final items = await useCase.execute();
      state = ItemState.success(items);
    } catch (e) {
      print("❌ Error fetching items: $e");
      state = ItemState.error("Failed to load items");
    }
  }

  Future<void> borrowItem(String itemId) async {
    await borrowItemUseCase.execute(itemId);

    final userId = await getUserIdFromToken();
    if (userId != null) {
      fetchBorrowedItems(userId); // ✅ Pass the actual userId
    } else {
      print("❌ Could not fetch userId from token");
    }
  }


  Future<void> fetchBorrowedItems(String userId) async {
    if (userId.isEmpty) {
      state = state.copyWith(error: "User ID is invalid");
      return;
    }

    try {
      final items = await getBorrowedItemsUseCase.execute(userId);
      for (final item in items) {}

      state = state.copyWith(
        isLoading: false,
        borrowedItems: items,
      );
    } catch (e, st) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateBorrowNote(String itemId, String note) async {
    try {
      final success = await updateNoteUseCase.execute(itemId, note);

      if (success) {
        state = state.copyWith(
          borrowedItems: state.borrowedItems.map((item) {
            return item.id == itemId ? item.copyWith(note: note) : item;
          }).toList(),
        );
      }
    } catch (e) {
      state = state.copyWith(error: "Failed to update note");
    }
  }
}