import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/order_model.dart';


class OrderController extends GetxController {
  final storage = GetStorage();
  var orders = <Order>[].obs;
  var isLoading = false.obs;

  void addOrder(String title, double total, String status, String image) {
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      total: total,
      status: status,
      image: image,
    );
    orders.add(newOrder);
    saveOrders();
  }
  void saveOrders() {
    final encoded = jsonEncode(orders.map((e) => e.toJson()).toList());
    storage.write('orders', encoded);
  }

  void updateOrderStatus(String orderId, String newStatus) {
    int index = orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final oldOrder = orders[index];
      orders[index] = Order(
        id: oldOrder.id,
        title: oldOrder.title,
        total: oldOrder.total,
        status: newStatus,
        image: oldOrder.image,
      );
    }
  }



}
