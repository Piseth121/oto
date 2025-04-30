import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://www.otokhi.com/api/product/home';
  static const String apiKey = '51a7afdfa81991cf2ce6cbd8d2ad51e528137d97';

  static Future<Map<String, dynamic>> fetchHomeProducts() async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'apiKey': apiKey}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('API Error ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Exception: $e');
      return {};
    }
  }
}
