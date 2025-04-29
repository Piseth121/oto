import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/Pages/main_page.dart';
import '../controllers/order_controller.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> with SingleTickerProviderStateMixin {
  final OrderController orderController = Get.put(OrderController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String getNextStatus(String currentStatus) {
    switch (currentStatus) {
      case 'Paid':
        return 'Processing';
      case 'Processing':
        return 'Shipped';
      case 'Shipped':
        return 'Delivered';
      case 'Delivered':
        return 'Completed';
      case 'Completed':
        return 'Completed';
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
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Processing Orders'),
            Tab(text: 'Completed Orders'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.home, color: Colors.orange, size: 28),
              onPressed: () => Get.to(MainPage()),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (orderController.orders.isEmpty) {
          return Center(child: Text('No Data'));
        }

        List ordersToShow;
        if (_tabController.index == 0) {
          // Processing Tab: Paid, Processing, Shipped, Delivered
          ordersToShow = orderController.orders.where((order) => order.status != 'Completed').toList();
        } else {
          // Completed Tab: Only Completed
          ordersToShow = orderController.orders.where((order) => order.status == 'Completed').toList();
        }

        return _buildOrderList(ordersToShow);
      }),
    );
  }

  Widget _buildOrderList(List orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return GestureDetector(
          onTap: () {
            orderController.saveOrders();
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(order.image),
                  ),
                  title: Text(order.title),
                  subtitle: Text("ID: ${order.id}"),
                  trailing: Text(
                    "\$${order.total.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Divider(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Status:",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 10),
                            Text(
                              " ${order.status}",
                              style: TextStyle(
                                color: getStatusColor(order.status),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
