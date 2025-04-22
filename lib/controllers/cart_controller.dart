import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../constant_model/models.dart';

class CartController extends GetxController {
  var cartItems = <NewProduct>[].obs;
  final storage = GetStorage();
  final String _storageKey = 'cart';

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void addToCart(NewProduct product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      cartItems[index].quantity++;
    } else {
      product.quantity = 1;
      cartItems.add(product);
    }
    saveCart();
  }

  void removeFromCart(NewProduct product) {
    cartItems.removeWhere((item) => item.id == product.id);
    saveCart();
  }

  void increaseQuantity(NewProduct product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
      saveCart();
    }
  }

  void decreaseQuantity(NewProduct product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } 
    cartItems.refresh();
    saveCart();
  }

  double get total {
    return cartItems.fold(
      0.0,
          (sum, item) => sum + (item.prices * item.quantity),
    );
  }

  void saveCart() {
    final List<Map<String, dynamic>> cartJson =
    cartItems.map((item) => item.toJson()).toList();
    storage.write(_storageKey, jsonEncode(cartJson));
  }

  void loadCart() {
    final data = storage.read(_storageKey);
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      cartItems.assignAll(decoded.map((e) => NewProduct.fromJson(e)).toList());
    }
  }
}
