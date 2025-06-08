// state/item_state.dart
import '../../../domain/entities/item_entity.dart';
import '../../../domain/entities/item_entity.dart';

class ItemState {
  final bool isLoading;
  final String? error;
  final List<ItemEntity> items;

  ItemState({required this.isLoading, this.error, required this.items});

  factory ItemState.initial() => ItemState(isLoading: false, error: null, items: []);
  factory ItemState.loading() => ItemState(isLoading: true, error: null, items: []);
  factory ItemState.error(String msg) => ItemState(isLoading: false, error: msg, items: []);
  factory ItemState.success(List<ItemEntity> items) => ItemState(isLoading: false, error: null, items: items);
}
