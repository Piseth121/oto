import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';

class MyOrderPage extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(child: Text(order.id)),
                title: Text(order.title),
                subtitle: Text("Status: ${order.status}"),
                trailing: Text("\$${order.total.toStringAsFixed(2)}"),
              ),
            );
          },
        );
      }),
    );
  }
}
