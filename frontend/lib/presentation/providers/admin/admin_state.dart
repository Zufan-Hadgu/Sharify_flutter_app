import '../../../domain/entities/item_entity.dart';

class AdminState {
  final int totalUsers;
  final int availableItems;
  final List<ItemEntity> items;
  final bool isLoading;
  final String? error;

  AdminState({
    required this.totalUsers,
    required this.availableItems,
    required this.items,
    this.isLoading = false,
    this.error,
  });

  factory AdminState.initial() => AdminState(
    totalUsers: 0,
    availableItems: 0,
    items: [],
    isLoading: false,
  );

  AdminState copyWith({
    int? totalUsers,
    int? availableItems,
    List<ItemEntity>? items,
    bool? isLoading,
    String? error,
  }) {
    return AdminState(
      totalUsers: totalUsers ?? this.totalUsers,
      availableItems: availableItems ?? this.availableItems,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}