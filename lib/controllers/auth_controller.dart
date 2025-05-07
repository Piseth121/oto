import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  final box = GetStorage();
  final AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    try {
      final result = await _authService.login(email, password);
      final statusCode = result['statusCode'];
      final data = result['body'];

      print('🔐 Login Response: $data');

      if (statusCode == 200 && data['status'] == true) {
        box.write('isLoggedIn', true);
        box.write('user', data['user']);
        box.write('token', data['token']); // optional

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
      print('❌ Login error: $e');
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      final result = await _authService.signUp(email, password, name);
      final statusCode = result['statusCode'];
      final data = result['body'];

      if (statusCode == 200 && data['status'] == true) {
        box.write('isLoggedIn', true);
        box.write('user', data['user']);
        isLoggedIn.value = true;

        Get.snackbar('Success', 'Account created successfully!');
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Sign Up Failed', data['message'] ?? 'Unable to create account');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void logout() {
    box.erase();
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
