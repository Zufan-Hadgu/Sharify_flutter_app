import '../../../domain/entities/item_entity.dart';

class ItemState {
  final bool isLoading;
  final String? error;
  final List<ItemEntity> items;
  final List<ItemEntity> borrowedItems; // ✅ Added borrowedItems field

  ItemState({
    required this.isLoading,
    this.error,
    required this.items,
    required this.borrowedItems,
  });

  factory ItemState.initial() => ItemState(isLoading: false, error: null, items: [], borrowedItems: []);
  factory ItemState.loading() => ItemState(isLoading: true, error: null, items: [], borrowedItems: []);
  factory ItemState.error(String msg) => ItemState(isLoading: false, error: msg, items: [], borrowedItems: []);
  factory ItemState.success(List<ItemEntity> items) => ItemState(isLoading: false, error: null, items: items, borrowedItems: []);
  factory ItemState.borrowedSuccess(List<ItemEntity> borrowedItems) => ItemState(isLoading: false, error: null, items: [], borrowedItems: borrowedItems);

  // ✅ Add `copyWith` method to allow state updates
  ItemState copyWith({bool? isLoading, String? error, List<ItemEntity>? items, List<ItemEntity>? borrowedItems}) {
    return ItemState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      items: items ?? this.items,
      borrowedItems: borrowedItems ?? this.borrowedItems,
    );
  }
}