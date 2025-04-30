import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/cart_page.dart';
import '../controllers/cart_controller.dart';
import '../controllers/favorite_controller.dart';

class FavoriteListScreen extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite List')),
      body: Obx(() {
        if (favoriteController.favoriteItems.isEmpty) {
          return Center(child: Text('No favorite items'));
        } return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: favoriteController.favoriteItems.length,
          itemBuilder: (context, index) {
            final item = favoriteController.favoriteItems[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        item.images.isEmpty? Image.asset('assets/images/no_image.png', width: 100, height: 100, fit: BoxFit.cover) : Image.network(item.images[0], width: 100, height: 100, fit: BoxFit.cover),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text(item.price.toString(), style: TextStyle(color: Colors.green)),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.orange, size: 16),
                                  // Text('${item.productRating} (${item.price.toString()})'),
                                ],
                              ),
                              Text(item.quantity.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {},
                        ),
                        item.quantity > 0
                            ? ElevatedButton(
                          style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.blue,width: 1)),
                          onPressed: () {
                            cartController.addToCart(item); // 🛒 Add product
                            Get.to(() => CartPage());
                          },
                          child: Text("Add to Cart"),
                        )
                            : ElevatedButton(style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.red,width: 1)),
                          onPressed: (){
                              Get.snackbar("Out of Stock", "This product is currently out of stock.", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red,);
                          },
                          child: Text("Out of Stock", style: TextStyle(color: Colors.red)),),
                      ],
                    )
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