
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharify_flutter_app/core/provider/provider.dart';

import 'package:sharify_flutter_app/domain/repositories/item_repository.dart';
import 'package:sharify_flutter_app/domain/usecase/user/get_item_usecase.dart';
import 'package:sharify_flutter_app/infrastructure/repositories/item_repository_impl.dart';
import 'package:sharify_flutter_app/presentation/providers/user/item_notifier.dart';
import 'package:sharify_flutter_app/presentation/providers/user/item_state.dart';

import '../../domain/usecase/user/borrow_iem_usecase.dart';
import '../../domain/usecase/user/get_borrowed_item_usecase.dart';
import '../../domain/usecase/user/get_item_by_id_usecase.dart';
import '../../infrastructure/datasources/local/item_local.dart';
import '../../infrastructure/datasources/remote/item_remote.dart';


final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ItemRepositoryImpl(ItemLocalDataSource.instance, ItemRemoteDataSource(dio));
});

final getItemsUseCaseProvider = Provider((ref) => GetItemsUseCase(ref.watch(itemRepositoryProvider)));
final getItemByIdUseCaseProvider = Provider((ref) => GetItemByIdUseCase(ref.read(itemRepositoryProvider)));
final borrowItemUseCaseProvider = Provider((ref) => BorrowItemUseCase(ref.watch(itemRepositoryProvider)));
final getBorrowedItemsUseCaseProvider = Provider((ref) => GetBorrowedItemsUseCase(ref.watch(itemRepositoryProvider)));

final itemNotifierProvider = StateNotifierProvider<ItemNotifier, ItemState>((ref) {
  final useCase = ref.watch(getItemsUseCaseProvider);
  final borrowItemUseCaseProvide = ref.watch(borrowItemUseCaseProvider);
  final getBorrowedItemsUseCase = ref.watch(getBorrowedItemsUseCaseProvider);
  return ItemNotifier(useCase,borrowItemUseCaseProvide,getBorrowedItemsUseCase);
});
