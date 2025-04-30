import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/cart_page.dart';
import '../Pages/product_detail.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';

class ItemAll extends StatelessWidget {
  final Product pros;
  ItemAll({super.key, required this.pros});
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(proData: pros)),
        );
      },
      child: Container(
        width: 150,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image:
                          pros.images.isEmpty
                              ? AssetImage('assets/images/no_image.png')
                                  as ImageProvider
                              : NetworkImage(pros.images[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(pros.name, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "battambang")),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${pros.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cartController.addToCart(pros); // 🛒 Add product
                      print("Added to Cart: ${pros.name}");
                      Get.to(CartPage());
                      ;
                    },
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
