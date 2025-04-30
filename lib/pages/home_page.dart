import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/product_controller.dart';
import '../pages/cart_page.dart';
import '../widgets/favorite.dart';
import '../widgets/itme_card_1.dart';
import 'home_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController controller = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          appBar: AppBar(
            title: Text('OTOKHI'),
            backgroundColor: Colors.black,
          ),
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return DefaultTabController(
        length: controller.categories.length + 1, // +1 for HomeProduct
        child: Scaffold(
          appBar: AppBar(
            title: Text('OTOKHI', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor: Colors.black,
            actions: [
              Obx(() {
                return Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.white),
                      onPressed: () => Get.to(() => FavoriteListScreen()),
                    ),
                    if (favoriteController.favoriteItems.isNotEmpty)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${favoriteController.favoriteItems.length}',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                );
              }),
              Obx(() {
                return Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () => Get.to(() => CartPage()),
                    ),
                    if (cartController.cartItems.isNotEmpty)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cartController.cartItems.length}',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: ColoredBox(
                color: Colors.white,
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.black,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(child: Text("ផលិតផល", style: TextStyle(fontFamily: "battambang", fontSize: 16))),
                    ...controller.categories.map((cat) => Tab(
                      child: Text(cat['name'], style: TextStyle(fontFamily: "battambang", fontSize: 16)),
                    )),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              HomeProduct(), // Home Tab
              ...controller.categories.map((cat) {
                int categoryId = cat['id'];
                var items = controller.productsByCategory[categoryId] ?? [];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: items.length,
                    primary: false,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (context, index) => ItemCard(pro: items[index]),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      );
    });
  }
}
