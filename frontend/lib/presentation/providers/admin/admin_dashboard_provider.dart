import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/network/api_provider.dart';
import '../../../domain/usecase/admin/get_total_users_usecase.dart';
import '../../../domain/usecase/admin/get_total_items_usecase.dart';
import '../../../infrastructure/datasources/remote/admin_remote_datasource.dart';
import '../../../../infrastructure/repositories/admin_repository_impl.dart';
import 'admin_dashboard_notifier.dart';
import 'admin_dashboard_state.dart';

final apiProvider = Provider((ref) => ApiProvider());

final adminRemoteProvider = Provider((ref) => AdminRemoteDataSource(ref.watch(apiProvider)));

final adminRepositoryProvider = Provider((ref) => AdminRepositoryImpl(ref.watch(adminRemoteProvider)));

final getTotalUsersUseCaseProvider = Provider((ref) => GetTotalUsersUseCase(ref.watch(adminRepositoryProvider)));

final getTotalItemsUseCaseProvider = Provider((ref) => GetTotalItemsUseCase(ref.watch(adminRepositoryProvider)));

final adminDashboardProvider =
StateNotifierProvider<AdminDashboardNotifier, AdminDashboardState>((ref) {
  final users = ref.watch(getTotalUsersUseCaseProvider);
  final items = ref.watch(getTotalItemsUseCaseProvider);
  return AdminDashboardNotifier(users, items);
});
