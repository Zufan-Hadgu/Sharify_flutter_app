// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../domain/usecase/admin/add_item_usecase.dart';
// import '../../domain/usecase/user/get_item_usecase.dart';
// import '../../infrastructure/datasources/remote/item_remote_datasource.dart';
// import '../../infrastructure/repositories/admin_item_repo_impl.dart';
// import '../../presentation/providers/admin/admin_dashboard_provider.dart';
// import '../../presentation/providers/admin/admin_item_notifier.dart';
// import '../network/dio_client.dart';
// import 'item_provider.dart';
//
//
//
//
// final adminItemRemoteProvider = Provider<AdminItemRemoteDataSource>(
//       (ref) => AdminItemRemoteDataSource(ref.watch(dioProvider)),
// );
//
// final adminItemRepositoryProvider = Provider<AdminItemRepositoryImpl>(
//       (ref) => AdminItemRepositoryImpl(ref.watch(adminItemRemoteProvider)),
// );
//
// final adminAddItemUseCaseProvider = Provider<AdminAddItemUseCase>(
//       (ref) => AdminAddItemUseCase(ref.watch(adminItemRepositoryProvider)),
// );
// final getItemsUseCaseProvider = Provider((ref) => GetItemsUseCase(ref.watch(itemRepositoryProvider)));
// final adminItemProvider = StateNotifierProvider<AdminItemNotifier, AdminItemState>((ref) {
//   return AdminItemNotifier(
//     ref.watch(adminAddItemUseCaseProvider),
//     ref.watch(getItemsUseCaseProvider),
//   );
// });