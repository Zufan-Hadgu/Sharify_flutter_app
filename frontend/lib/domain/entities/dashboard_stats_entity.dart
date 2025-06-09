class DashboardStatsEntity {
  final int totalActiveUsers;
  final int totalItems;

  DashboardStatsEntity({
    required this.totalActiveUsers,
    required this.totalItems,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashboardStatsEntity &&
        other.totalActiveUsers == totalActiveUsers &&
        other.totalItems == totalItems;
  }

  @override
  int get hashCode => totalActiveUsers.hashCode ^ totalItems.hashCode;
}