import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  void login(String email, String password) {
    // Simulate login
    print('Logging in with $email');
    isLoggedIn.value = true;
    Get.offAllNamed('/home');
  }

  void signUp(String email, String password, String name) {
    // Simulate signup
    print('Signing up with $email');
    isLoggedIn.value = true;
    Get.offAllNamed('/home');
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
