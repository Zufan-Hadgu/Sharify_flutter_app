// import 'package:dio/dio.dart';
// import '../../../core/utils/SaveJWT.dart';
// import '../../../domain/entities/item_entity.dart';
// import '../../models/Item_model.dart';
//
// class AdminRemoteDataSource {
//   final Dio dio;
//
//   AdminRemoteDataSource(this.dio);
//
//   /// ✅ Fetch Admin Dashboard Statistics
//   Future<Map<String, int>> fetchDashboardStats() async {
//     try {
//       final response = await dio.get('/api/admin/statistics');
//       final data = response.data as Map<String, dynamic>;
//       final totalUsers = data['totalUsers'] ?? 0;
//       final availableItems = data['availableItems'] ?? 0;
//       return {
//         'totalUsers': totalUsers,
//         'availableItems': availableItems,
//       };
//     } catch (e) {
//       return {'totalUsers': 0, 'availableItems': 0};
//     }
//   }
//
//   /// ✅ Add a New Admin Item
//   Future<void> addAdminItem(ItemEntity item, MultipartFile image) async {
//     try {
//       final formData = FormData.fromMap({
//         "image": image,
//         "name": item.name,
//         "smalldescription": item.smalldescription,
//         "description": item.description,
//         "termsAndConditions": item.termsAndConditions,
//         "telephone": item.telephon,
//         "address": item.address,
//       });
//
//       await dio.post("/api/admin/add-item", data: formData);
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<List<ItemModel>> fetchAdminItems() async {
//     try {
//
//       final token = await getJWT();
//       final response = await dio.get(
//         '/api/admin/items',
//         options: Options(headers: {'Authorization': 'Bearer $token'}),
//       );
//
//       if (response.statusCode == 200) {
//         if (response.data == null) {
//           return [];
//         }
//
//         if (!response.data.containsKey("items") || response.data["items"] == null) {
//           return [];
//         }
//
//         final List<dynamic> itemsList = response.data["items"];
//
//         if (itemsList.isEmpty) {
//           return [];
//         }
//         return itemsList.map((json) {
//           return ItemModel.fromJson(json);
//         }).toList();
//       } else {
//         throw Exception("API returned status: ${response.statusCode}");
//       }
//     } catch (e, stackTrace) {
//       print("🧾 Stack trace: $stackTrace");
//       return [];
//     }
//   }
// }


import 'package:dio/dio.dart';
import '../../../core/utils/SaveJWT.dart';
import '../../../domain/entities/item_entity.dart';
import '../../models/Item_model.dart';

class AdminRemoteDataSource {
  final Dio dio;

  AdminRemoteDataSource(this.dio);

  /// ✅ Fetch Admin Dashboard Statistics
  Future<Map<String, int>> fetchDashboardStats() async {
    try {
      final response = await dio.get('/api/admin/statistics');
      final data = response.data as Map<String, dynamic>;
      final totalUsers = data['totalUsers'] ?? 0;
      final availableItems = data['availableItems'] ?? 0;
      return {
        'totalUsers': totalUsers,
        'availableItems': availableItems,
      };
    } catch (e) {
      return {'totalUsers': 0, 'availableItems': 0};
    }
  }

  /// ✅ Add a New Admin Item
  Future<void> addAdminItem(ItemEntity item, MultipartFile image) async {
    try {
      final formData = FormData.fromMap({
        "image": image,
        "name": item.name,
        "smalldescription": item.smalldescription,
        "description": item.description,
        "termsAndConditions": item.termsAndConditions,
        "telephone": item.telephon,
        "address": item.address,
      });

      await dio.post("/api/admin/add-item", data: formData);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ItemModel>> fetchAdminItems() async {
    try {

      final token = await getJWT();
      final response = await dio.get(
        '/api/admin/items',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          return [];
        }

        if (!response.data.containsKey("items") || response.data["items"] == null) {
          return [];
        }

        final List<dynamic> itemsList = response.data["items"];

        if (itemsList.isEmpty) {
          return [];
        }
        return itemsList.map((json) {
          return ItemModel.fromJson(json);
        }).toList();
      } else {
        throw Exception("API returned status: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("🧾 Stack trace: $stackTrace");
      return [];
    }
  }

  Future<void> updateItem({
    required String itemId,
    required ItemEntity item,
    required MultipartFile? image,
  }) async {

    final formData = FormData.fromMap({
      "name": item.name,
      "smalldescription": item.smalldescription,
      "description": item.description,
      "termsAndConditions": item.termsAndConditions,
      "telephone": item.telephon,
      "address": item.address,
      "isAvailable": item.isAvailable,
    });

    if (image != null) {
      formData.files.add(MapEntry("image", image)); // ✅ Adds image as a file upload
    }

    final response = await dio.put(
      "/api/admin/update-item/$itemId",
      data: formData,
    );
  }
  Future<void> deleteItem(String itemId) async {
    try {
      final token = await getJWT();

      final response = await dio.delete(
        "/api/admin/delete-item/$itemId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
    } catch (e) {
      print("Error deleting item: $e");
    }
  }


}








