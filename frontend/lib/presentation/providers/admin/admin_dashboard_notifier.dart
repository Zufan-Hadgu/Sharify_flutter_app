import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../domain/usecase/admin/get_total_items_usecase.dart';
import '../../../domain/usecase/admin/get_total_users_usecase.dart';
import 'admin_dashboard_state.dart';

class AdminDashboardNotifier extends StateNotifier<AdminDashboardState> {
  final GetTotalUsersUseCase getTotalUsersUseCase;
  final GetTotalItemsUseCase getTotalItemsUseCase;

  AdminDashboardNotifier(this.getTotalUsersUseCase, this.getTotalItemsUseCase)
      : super(AdminDashboardState.initial()) {
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    print("🟢 Triggering fetchDashboardStats()");

    try {
      state = state.copyWith(isLoading: true);
      final users = await getTotalUsersUseCase();
      final items = await getTotalItemsUseCase();
      state = AdminDashboardState(
        totalUsers: users,
        availableItems: items,
        isLoading: false,
      );
    } catch (e) {
      state = AdminDashboardState(
        totalUsers: 0,
        availableItems: 0,
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}