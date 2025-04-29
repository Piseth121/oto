import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant_model/top_selling.dart';
import '../../widgets/all.dart';
import '../../widgets/checkout_page.dart';
import '../../widgets/popular.dart';
import '../controllers/cart_controller.dart';
import 'categories_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.find<CartController>();
  int _selectedIndex = 0;
  // List of menu items
  final List<String> _menuItems = [
    'All',
    'Popular',
    'New',
    'Trending',
    'Favorites',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: ListView(
              children: [
                // Horizontal menu row
                SizedBox(height: 10),
                Center(child: Text("Your cart is empty")),
                Center(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Categories()),
                        );
                      });
                    },
                    child: Text(
                      "Source by category",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    color: Colors.transparent,
                    child: Text("You're protected on OTOKHI"),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  color: Colors.transparent,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.add_moderator_outlined,
                              color: Colors.green,
                            ),
                            Text("Secure payment"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.web_outlined, color: Colors.green),
                            Text("Refund and returns"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.directions_car_filled_outlined,
                              color: Colors.green,
                            ),
                            Text("Fulfillment by OTOKHI Logistics"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 20),
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _menuItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Update the selected index
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                _selectedIndex == index
                                    ? Colors.blue
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              _menuItems[index],
                              style: TextStyle(
                                color:
                                    _selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Display content based on the selected menu item
                IndexedStack(
                  index: _selectedIndex,
                  children: [
                    all(),
                    _buildPopular(),
                    all(),
                    _buildPopular(),
                    Container(child: Center(child: Text('Favorites page'))),
                  ],
                ),
              ],
            ),
          );
        } else {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: cartController.cartItems.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = cartController.cartItems[index];
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          item.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(item.name),
                      subtitle: Text('\$${item.prices} X ${item.quantity}'),
                      trailing: Text(
                        '\$${(item.prices * item.quantity).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  cartController.decreaseQuantity(item);
                                },
                                icon: const Icon(Icons.remove),
                                padding: EdgeInsets.zero,
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                onPressed: () {
                                  cartController.increaseQuantity(item);
                                },
                                icon: const Icon(Icons.add),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cartController.removeFromCart(item);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${cartController.total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => CheckoutPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget all() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: topselling.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          childAspectRatio: 0.85,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => ItemAll(pros: topselling[index]),
      ),
    );
  }

  Widget _buildPopular() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: topselling.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          childAspectRatio: 0.80,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => Popular(pop: topselling[index]),
      ),
    );
  }
}
