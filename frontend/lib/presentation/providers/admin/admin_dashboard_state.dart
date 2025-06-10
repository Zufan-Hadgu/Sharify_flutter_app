class AdminDashboardState {
  final int totalUsers;
  final int availableItems;
  final bool isLoading;
  final String? error;

  const AdminDashboardState({
    required this.totalUsers,
    required this.availableItems,
    this.isLoading = false,
    this.error,
  });

  factory AdminDashboardState.initial() => const AdminDashboardState(
    totalUsers: 0,
    availableItems: 0,
    isLoading: true,
  );

  AdminDashboardState copyWith({
    int? totalUsers,
    int? availableItems,
    bool? isLoading,
    String? error,
  }) {
    return AdminDashboardState(
      totalUsers: totalUsers ?? this.totalUsers,
      availableItems: availableItems ?? this.availableItems,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}