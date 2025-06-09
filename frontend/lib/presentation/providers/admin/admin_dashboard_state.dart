class AdminDashboardState {
  final int totalUsers;
  final int totalItems;
  final bool isLoading;

  AdminDashboardState({
    required this.totalUsers,
    required this.totalItems,
    required this.isLoading,
  });

  factory AdminDashboardState.initial() => AdminDashboardState(
    totalUsers: 0,
    totalItems: 0,
    isLoading: true,
  );

  AdminDashboardState copyWith({
    int? totalUsers,
    int? totalItems,
    bool? isLoading,
  }) {
    return AdminDashboardState(
      totalUsers: totalUsers ?? this.totalUsers,
      totalItems: totalItems ?? this.totalItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
