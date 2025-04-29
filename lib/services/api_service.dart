import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://www.otokhi.com/api/product/home';
  static const String _apiKey = '51a7afdfa81991cf2ce6cbd8d2ad51e528137d97';

  static Future<Map<String, dynamic>> fetchHomeProducts() async {
    try {
      var response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"apiKey": _apiKey}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}