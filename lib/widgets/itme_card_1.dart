import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/product_detail.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';
import 'loading_skeleton.dart';



class ItemCard extends StatelessWidget {
  final Product pro;

  ItemCard({super.key, required this.pro});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final item = pro;
    return Obx(() {
      if (cartController.isLoading.value) {
        return ShimmerBox(width: 150, height: 220);
      }
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: InkWell(
          onTap: () => Get.to(() => DetailPage(proData: item)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.41,
            height: 220, // Ensure height is fixed to avoid layout errors
            child: Card(
              elevation: 4,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: item.images.isNotEmpty
                              ? NetworkImage(item.images[0])
                              : AssetImage('assets/images/no_image.png') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      item.name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "battambang"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${item.price}",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                             cartController.addToCart(item);
                            Get.snackbar("Added to Cart", "${item.name} has been added to your cart.",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.grey.withOpacity(0.7),
                                colorText: Colors.white);
                          },
                          icon: Icon(Icons.add_shopping_cart, color: Colors.red, size: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
