import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/all.dart';
import '../../widgets/checkout_page.dart';
import '../../widgets/popular.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import 'categories_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = Get.find<CartController>();
  final ProductController productController = Get.find<ProductController>();
  int _selectedIndex = 0;

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
        title: const Text('Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return ListView(
            children: [
              SizedBox(height: 10),
              Center(child: Text("Your cart is empty")),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Categories()),
                    );
                  },
                  child: Text("Source by category", style: TextStyle(color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text("You're protected on OTOKHI"),
              ),
              _protectionInfo(),
              Divider(height: 20),
              _menuTabs(),
              IndexedStack(
                index: _selectedIndex,
                children: [
                  all(),
                  _buildPopular(),
                  all(),
                  _buildPopular(),
                  Center(child: Text('Favorites page')),
                ],
              ),
            ],
          );
        } else {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: cartController.cartItems.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = cartController.cartItems[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: item.images.isNotEmpty
                              ? Image.network(
                            item.images[0],
                            width: 100,
                            height: 130,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            'assets/images/no_image.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "battambang",
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            Text('\$${item.price} x ${item.quantity}', style: TextStyle(fontSize: 14)),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Total: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('\$${(item.price * item.quantity).toStringAsFixed(2)}',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.green,fontSize: 16),)
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => cartController.decreaseQuantity(item),
                                  icon: Icon(Icons.remove),
                                  padding: EdgeInsets.zero,
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  onPressed: () => cartController.increaseQuantity(item),
                                  icon: Icon(Icons.add),
                                  padding: EdgeInsets.zero,
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Remove Item"),
                                        content: Text("Are you sure you want to remove '${item.name}' from the cart?",style: TextStyle(fontFamily: "battambang"),),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                            onPressed: () {
                                              cartController.removeFromCart(item);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Remove", style: TextStyle(color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },

                                  icon: Icon(Icons.delete, color: Colors.red),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },

          );
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Total: \$${cartController.total.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
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
                  child: const Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _protectionInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(Icons.add_moderator_outlined, color: Colors.green), Text(" Secure payment")]),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.web_outlined, color: Colors.green), Text(" Refund and returns")]),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.local_shipping_outlined, color: Colors.green), Text(" Fast shipping")]),
        ],
      ),
    );
  }

  Widget _menuTabs() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _selectedIndex == index ? Colors.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _menuItems[index],
                  style: TextStyle(
                    color: _selectedIndex == index ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget all() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: productController.topSolds.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => ItemAll(pros: productController.topSolds[index]),
        ),
      );
    });
  }

  Widget _buildPopular() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: productController.recommendeds.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            childAspectRatio: 0.80,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => Popular(pop: productController.recommendeds[index]),
        ),
      );
    });
  }
}
