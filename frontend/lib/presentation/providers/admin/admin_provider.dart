
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/provider/item_provider.dart';
import '../../../domain/usecase/admin/add_item_usecase.dart';
import '../../../domain/usecase/admin/delete_item_usecase.dart';
import '../../../domain/usecase/admin/get_admin_item_usecase.dart';
import '../../../domain/usecase/admin/get_total_items_usecase.dart';
import '../../../domain/usecase/admin/get_total_users_usecase.dart';
import '../../../domain/usecase/admin/update_item_usecase.dart';
import '../../../domain/usecase/user/get_item_usecase.dart';
import '../../../infrastructure/datasources/remote/admin_remote_datasource.dart';
import '../../../infrastructure/repositories/admin_repository_impl.dart';
import '../user/item_notifier.dart';
import '../user/item_state.dart';
import 'admin_notifier.dart';
import 'admin_state.dart';

final dioProvider = Provider((ref) => DioClient().dio);

final adminRemoteProvider = Provider((ref) => AdminRemoteDataSource(ref.watch(dioProvider)));
final adminRepositoryProvider = Provider((ref) => AdminRepositoryImpl(ref.watch(adminRemoteProvider)));

final getTotalUsersUseCaseProvider = Provider((ref) => GetTotalUsersUseCase(ref.watch(adminRepositoryProvider)));

final getTotalItemsUseCaseProvider = Provider((ref) => GetTotalItemsUseCase(ref.watch(adminRepositoryProvider)));


final adminAddItemUseCaseProvider = Provider((ref) => AdminAddItemUseCase(ref.watch(adminRepositoryProvider)));
final getAdminItemsUseCaseProvider = Provider<GetAdminItemsUseCase>((ref) {
  return GetAdminItemsUseCase(ref.watch(adminRepositoryProvider));
});

final updateItemUseCaseProvider = Provider((ref) => UpdateItemUseCase(ref.watch(adminRepositoryProvider)));
final deleteItemUseCaseProvider = Provider((ref) => DeleteItemUseCase(ref.watch(adminRepositoryProvider)));

final adminProvider = StateNotifierProvider<AdminNotifier, AdminState>((ref) {
  return AdminNotifier(
    ref.watch(getTotalUsersUseCaseProvider),
    ref.watch(getTotalItemsUseCaseProvider),
    ref.watch(getAdminItemsUseCaseProvider),
    ref.watch(adminAddItemUseCaseProvider),
    ref.watch(updateItemUseCaseProvider),
    ref.watch(deleteItemUseCaseProvider),
    ref,
  );
});