// datasources/remote/item_remote.dart
import 'package:dio/dio.dart';
import '../../../core/utils/SaveJWT.dart';
import '../../models/Item_model.dart';

class ItemRemoteDataSource {
  final Dio dio;
  ItemRemoteDataSource(this.dio);

  Future<List<ItemModel>> fetchItems() async {
    try {

      final token = await getJWT();
      final response = await dio.get('/api/admin/items',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        final data = response.data['items'] as List;
        print("✅ Items Found in API Response: ${data.length}"); // ✅ Ensure count matches backend

        final parsedItems = data.map((json) => ItemModel.fromJson(json)).toList();
        print("🔄 Parsed Items: ${parsedItems.length}"); // ✅ Verify proper mapping

        return parsedItems;
      } else {
        throw Exception("API returned status: ${response.statusCode}");
      }
    } catch (error) {
      return [];
    }
  }
}