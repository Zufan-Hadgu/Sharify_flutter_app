// import 'dart:ui';
//
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:dio/dio.dart';
// import 'package:sharify_flutter_app/domain/usecase/admin/get_admin_item_usecase.dart';
// import '../../../core/provider/item_provider.dart';
// import '../../../domain/entities/item_entity.dart';
// import '../../../domain/usecase/admin/get_total_items_usecase.dart';
// import '../../../domain/usecase/admin/get_total_users_usecase.dart';
//
// import '../../../domain/usecase/admin/add_item_usecase.dart';
// import '../../../domain/usecase/user/get_item_usecase.dart';
// import 'admin_state.dart';
//
// class AdminNotifier extends StateNotifier<AdminState> {
//   final GetTotalUsersUseCase getTotalUsersUseCase;
//   final GetTotalItemsUseCase getTotalItemsUseCase;
//   final GetAdminItemsUseCase getAdminItemsUseCase;
//   final AdminAddItemUseCase adminAddItemUseCase;
//   final Ref ref;
//
//   AdminNotifier(
//       this.getTotalUsersUseCase,
//       this.getTotalItemsUseCase,
//       this.getAdminItemsUseCase,
//       this.adminAddItemUseCase,
//   this.ref,
//       ) : super(AdminState.initial()) {
//     loadAdminData(); // ✅ Load dashboard stats & items on initialization
//   }
//
//   Future<void> loadAdminData() async {
//     print("🟢 Loading Admin Dashboard and Items...");
//
//     try {
//       state = state.copyWith(isLoading: true);
//
//       final users = await getTotalUsersUseCase.execute();
//       final itemsCount = await getTotalItemsUseCase.execute();
//       final itemsList = await getAdminItemsUseCase.execute() ?? [];
//
//       state = state.copyWith(
//         totalUsers: users,
//         availableItems: itemsCount,
//         items: itemsList,
//         isLoading: false,
//       );
//     } catch (e) {
//       state = state.copyWith(error: "❌ Error loading admin data", isLoading: false);
//     }
//   }
//
//   Future<void> addAdminItem(ItemEntity item, MultipartFile image, VoidCallback onSuccess) async {
//     try {
//       state = state.copyWith(isLoading: true);
//
//       await adminAddItemUseCase.execute(item, image);
//
//       // ✅ Refresh dashboard & items list after addition
//       await loadAdminData();
//       ref.read(itemNotifierProvider.notifier).loadItems();
//
//       state = state.copyWith(isLoading: false);
//       onSuccess();
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }
//   Future<void> loadAdminItems() async {
//     print("🔄 [AdminNotifier] Fetching admin items...");
//     state = state.copyWith(isLoading: true);
//
//     try {
//       final itemsList = await getAdminItemsUseCase.execute() ?? [];
//
//       if (itemsList.isEmpty) {
//         print("⚠️ [AdminNotifier] No admin items found!");
//       } else {
//         print("✅ [AdminNotifier] Loaded ${itemsList.length} admin items!");
//       }
//
//       state = state.copyWith(items: itemsList, isLoading: false);
//     } catch (e, stackTrace) {
//       print("❌ [AdminNotifier] Error loading admin items: $e");
//       print("🧾 Stack trace: $stackTrace");
//
//       state = state.copyWith(error: "❌ Error loading admin items", isLoading: false);
//     }
//   }
//
// }


import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:sharify_flutter_app/domain/usecase/admin/get_admin_item_usecase.dart';
import '../../../core/provider/item_provider.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../domain/usecase/admin/get_total_items_usecase.dart';
import '../../../domain/usecase/admin/get_total_users_usecase.dart';

import '../../../domain/usecase/admin/add_item_usecase.dart';
import '../../../domain/usecase/admin/update_item_usecase.dart';
import '../../../domain/usecase/user/get_item_usecase.dart';
import 'admin_state.dart';

class AdminNotifier extends StateNotifier<AdminState> {
  final GetTotalUsersUseCase getTotalUsersUseCase;
  final GetTotalItemsUseCase getTotalItemsUseCase;
  final GetAdminItemsUseCase getAdminItemsUseCase;
  final AdminAddItemUseCase adminAddItemUseCase;
  final UpdateItemUseCase updateItemUseCase;// ✅ Add UpdateItemUseCase
  final Ref ref;

  AdminNotifier(
      this.getTotalUsersUseCase,
      this.getTotalItemsUseCase,
      this.getAdminItemsUseCase,
      this.adminAddItemUseCase,
      this.updateItemUseCase,
      this.ref,
      ) : super(AdminState.initial()) {
    loadAdminData(); // ✅ Load dashboard stats & items on initialization
  }

  Future<void> loadAdminData() async {
    print("🟢 Loading Admin Dashboard and Items...");

    try {
      state = state.copyWith(isLoading: true);

      final users = await getTotalUsersUseCase.execute();
      final itemsCount = await getTotalItemsUseCase.execute();
      final itemsList = await getAdminItemsUseCase.execute() ?? [];

      state = state.copyWith(
        totalUsers: users,
        availableItems: itemsCount,
        items: itemsList,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: "❌ Error loading admin data", isLoading: false);
    }
  }

  Future<void> addAdminItem(ItemEntity item, MultipartFile image, VoidCallback onSuccess) async {
    try {
      state = state.copyWith(isLoading: true);

      await adminAddItemUseCase.execute(item, image);

      // ✅ Refresh dashboard & items list after addition
      await loadAdminData();
      ref.read(itemNotifierProvider.notifier).loadItems();

      state = state.copyWith(isLoading: false);
      onSuccess();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
  Future<void> loadAdminItems() async {
    print("🔄 [AdminNotifier] Fetching admin items...");
    state = state.copyWith(isLoading: true);

    try {
      final itemsList = await getAdminItemsUseCase.execute() ?? [];

      if (itemsList.isEmpty) {
        print("⚠️ [AdminNotifier] No admin items found!");
      } else {
        print("✅ [AdminNotifier] Loaded ${itemsList.length} admin items!");
      }

      state = state.copyWith(items: itemsList, isLoading: false);
    } catch (e, stackTrace) {
      print("❌ [AdminNotifier] Error loading admin items: $e");
      print("🧾 Stack trace: $stackTrace");

      state = state.copyWith(error: "❌ Error loading admin items", isLoading: false);
    }
  }

  Future<void> updateItem({
    required String itemId,
    required ItemEntity item,
    required MultipartFile? image, // ✅ Uses MultipartFile for image
    required VoidCallback onSuccess, // ✅ Triggers callback after success
  }) async {
    try {
      print("🔄 [AdminNotifier] Updating item: $itemId...");
      state = state.copyWith(isLoading: true);

      await updateItemUseCase.execute(itemId, item, image);

      // ✅ Refresh dashboard & items list after update
      await loadAdminData();
      ref.read(itemNotifierProvider.notifier).loadItems();

      state = state.copyWith(isLoading: false);
      onSuccess(); // ✅ Call success callback
      print("✅ [AdminNotifier] Item updated successfully!");
    } catch (e) {
      print("❌ [AdminNotifier] Error updating item: $e");
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
