import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../domain/usecase/admin/get_total_items_usecase.dart';
import '../../../domain/usecase/admin/get_total_users_usecase.dart';
import '../../../infrastructure/datasources/remote/admin_remote_datasource.dart';
import '../../../infrastructure/repositories/admin_repository_impl.dart';
import 'admin_dashboard_notifier.dart';
import 'admin_dashboard_state.dart';

final dioProvider = Provider((ref) => DioClient().dio);

final adminRemoteProvider = Provider((ref) => AdminRemoteDataSource(ref.watch(dioProvider)));

final adminRepositoryProvider = Provider((ref) => AdminRepositoryImpl(ref.watch(adminRemoteProvider)));

final getTotalUsersUseCaseProvider = Provider((ref) => GetTotalUsersUseCase(ref.watch(adminRepositoryProvider)));

final getTotalItemsUseCaseProvider = Provider((ref) => GetTotalItemsUseCase(ref.watch(adminRepositoryProvider)));

final adminDashboardProvider = StateNotifierProvider<AdminDashboardNotifier, AdminDashboardState>((ref) {
  final users = ref.watch(getTotalUsersUseCaseProvider);
  final items = ref.watch(getTotalItemsUseCaseProvider);
  return AdminDashboardNotifier(users, items);
});