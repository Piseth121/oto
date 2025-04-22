import 'package:get/get.dart';
import '../models/order_model.dart';

class OrderController extends GetxController {
  var isLoading = true.obs;
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  void fetchOrders() async {
    await Future.delayed(Duration(seconds: 2)); // simulate loading
    var orderResult = [
      OrderModel(id: '001', title: 'Order #001', status: 'Delivered', total: 29.99),
      OrderModel(id: '002', title: 'Order #002', status: 'Processing', total: 19.49),
      OrderModel(id: '003', title: 'Order #003', status: 'Cancelled', total: 12.00),
    ];
    orders.assignAll(orderResult);
    isLoading.value = false;
  }
}
