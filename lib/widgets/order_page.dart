import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';

class MyOrderPage extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  String getNextStatus(String currentStatus) {
    switch (currentStatus) {
      case 'Paid':
        return 'Processing';
      case 'Processing':
        return 'Shipped';
      case 'Shipped':
        return 'Delivered';
      case 'Delivered':
        return 'Delivered'; // final state
      default:
        return 'Paid';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return Colors.red;
      case 'Processing':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Delivered':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: Obx(() {
        if (orderController.orders.isEmpty) {
          return Center(child: Text('No Data'));
        }

        return ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];
            return GestureDetector(
              onTap: () {
                orderController.saveOrders();
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(backgroundImage: AssetImage(order.image),),
                      title: Text(order.title),
                      subtitle: Text("ID: ${order.id}"),
                      trailing: Text("\$${order.total.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),),
                    ),
                    const Divider(),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Status:",style: TextStyle(color: Colors.black)),
                              SizedBox(width: 10,),
                              Text(" ${order.status}",style: TextStyle(color: getStatusColor(order.status),fontWeight: FontWeight.bold),)
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              orderController.updateOrderStatus(
                                order.id,
                                getNextStatus(order.status),
                              );
                            },
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
