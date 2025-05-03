import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  final box = GetStorage();

  Future<void> login(String email, String password) async {
    final url = Uri.parse('https://www.otokhi.com/api/user/login');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);
      print('Login Response: ${response.body}');

      if (response.statusCode == 200 && data['status'] == true) {
        // Save user info and token to local storage
        box.write('isLoggedIn', true);
        box.write('user', data['user']);
        box.write('token', data['token']); // only if token is returned

        isLoggedIn.value = true;

        Get.snackbar(
          'Login Success',
          'Welcome ${data['user']['name'] ?? email}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Login Failed', data['message'] ?? 'Invalid credentials');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
      print('Login error: $e');
    }
  }



  void signUp(String email, String password, String name) async {
    final url = Uri.parse('https://www.otokhi.com/api/user/signup');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': email,
      'password': password,
      'name': name
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        isLoggedIn.value = true;
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Sign Up Failed', 'Unable to create account');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
