import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseUrl = "http://10.0.2.2:4000/api";

  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}
