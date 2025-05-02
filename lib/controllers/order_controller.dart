
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/order_model.dart';


class OrderController extends GetxController {
  final storage = GetStorage();
  var orders = <Order>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  void addOrder(String title, double total, String status, List<String> images) {
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      total: total,
      status: status,
      images: images,
    );
    orders.add(newOrder);
    saveOrders();
  }

  void saveOrders() {
    List<Map<String, dynamic>> orderList = orders.map((order) => order.toJson()).toList();
    storage.write('orders', orderList);
  }
  void loadOrders() {
    List<dynamic>? orderList = storage.read('orders');
    if (orderList != null) {
      orders.assignAll(orderList.map((order) => Order.fromJson(order)).toList());
    }
    isLoading.value = false;
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
        images: oldOrder.images,
      );
    }
  }



}
