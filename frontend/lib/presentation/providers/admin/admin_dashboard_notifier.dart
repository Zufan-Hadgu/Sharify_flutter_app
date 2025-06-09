import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../domain/usecase/admin/get_total_users_usecase.dart';
import '../../../domain/usecase/admin/get_total_items_usecase.dart';
import 'admin_dashboard_state.dart';

class AdminDashboardNotifier extends StateNotifier<AdminDashboardState> {
  final GetTotalUsersUseCase getUsersUseCase;
  final GetTotalItemsUseCase getItemsUseCase;

  AdminDashboardNotifier(this.getUsersUseCase, this.getItemsUseCase)
      : super(AdminDashboardState.initial()) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true);
    try {
      final users = await getUsersUseCase();
      final items = await getItemsUseCase();

      print('Total users from backend: $users');
      print('Available items from backend: $items');

      state = state.copyWith(
        totalUsers: users,
        totalItems: items,
        isLoading: false,
      );
    } catch (e) {
      print(' Error loading dashboard data: $e');
      state = state.copyWith(isLoading: false);
    }
  }
}
