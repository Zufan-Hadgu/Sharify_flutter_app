import 'package:dio/dio.dart';
import '../../../core/utils/SaveJWT.dart';
import '../../models/Item_model.dart';

class ItemRemoteDataSource {
  final Dio dio;

  ItemRemoteDataSource(this.dio);

  Future<List<ItemModel>> fetchItems() async {
    try {
      final token = await getJWT();
      final response = await dio.get(
        '/api/admin/items',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final data = response.data['items'] as List;
        return data.map((json) => ItemModel.fromJson(json)).toList();
      } else {
        throw Exception("API returned status: ${response.statusCode}");
      }
    } catch (_) {
      return [];
    }
  }

  Future<bool> borrowItem(String itemId, String token) async {
    try {
      print("Starting borrow process for item in the borrowitem: $itemId");

      final response = await dio.put(
        '/api/borrow/borrow-item/$itemId',
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        }),
      );

      print("Response status for borrowing an item: ${response.statusCode}");
      print("Response data for borrowing item: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          print("Successfully borrowed item in the remote: $itemId");
          return true;
        } else {
          print("Borrowing failed: API did not return success.");
        }
      } else {
        print("Unexpected response code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error borrowing item: $error");
    }

    print("Borrowing process completed with failure.");
    return false;
  }

  Future<List<ItemModel>> fetchBorrowedItems() async {
    try {
      final token = await getJWT();
      final response = await dio.get(
        '/api/borrow/borrowed-items',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        final data = response.data['borrowedItems'] as List;
        return data.map((json) => ItemModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }

  Future<bool> updateNote(String itemId, String note, String token) async {
    try {

      final response = await dio.put(
        '/api/borrow/borrowed-item/note/$itemId',
        data: {"note": note},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );


      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      } else {

        return false;
      }
    } catch (e) {
      return false;
    }
  }
  Future<bool> removeBorrowedItem(String itemId, String token) async {
    try {
      final response = await dio.delete(
        '/api/borrow/borrowed-item/$itemId',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response.statusCode == 200 && response.data['success'] == true;
    } catch (e) {
      return false;
    }
  }

}