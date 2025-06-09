import '../../domain/entities/dashboard_stats_entity.dart';

/// Data model representing dashboard statistics from the API.
/// It includes methods for JSON serialization/deserialization and conversion to domain entity.
class DashboardStatsModel extends DashboardStatsEntity {
  DashboardStatsModel({
    required int totalActiveUsers,
    required int totalItems,
  }) : super(
    totalActiveUsers: totalActiveUsers,
    totalItems: totalItems,
  );

  /// Factory constructor to create a [DashboardStatsModel] from a JSON map.
  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalActiveUsers: json['totalActiveUsers'] as int, // Ensure key matches your backend API
      totalItems: json['totalItems'] as int,           // Ensure key matches your backend API
    );
  }

  /// Converts this [DashboardStatsModel] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'totalActiveUsers': totalActiveUsers,
      'totalItems': totalItems,
    };
  }

  /// Converts this model to a domain entity (already extends it, but explicit conversion is good practice).
  DashboardStatsEntity toEntity() {
    return DashboardStatsEntity(
      totalActiveUsers: totalActiveUsers,
      totalItems: totalItems,
    );
  }
}
