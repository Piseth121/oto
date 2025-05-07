import 'dart:io';
import 'package:http/http.dart' as http;

class ProfileService {
  final String uploadUrl = 'https://www.otokhi.com/api/user/upload-profile'; // ← adjust if different

  Future<http.Response> uploadProfileImage(File imageFile, String token) async {
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await http.Response.fromStream(await request.send());
    return response;
  }
}
