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
      final response = await dio.put(
        '/api/borrow/borrow-item/$itemId',
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        }),
      );

      return response.statusCode == 200 && response.data['success'] == true;
    } catch (_) {
      return false;
    }
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
}