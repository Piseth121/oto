
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant_model/models.dart';
import '../constant_model/new_product.dart';
import '../controllers/cart_controller.dart';
import 'detail_page.dart';

class NewProductsPage extends StatefulWidget {
  final CartController cartController = Get.put(CartController());
  NewProductsPage({super.key});

  @override
  State<NewProductsPage> createState() => _NewProductsPageState();
}

class _NewProductsPageState extends State<NewProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Products'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPro(),
          ],
        ),
      ),
    );
  }

  Widget _buildPro() {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        childAspectRatio: 0.70,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => _buildNewProItem(products[index]),
    );
  }

  Widget _buildNewProItem(NewProduct item) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailPage(proData: item)),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.41,
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
                    // width: MediaQuery.of(context).size.width*0.41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(item.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    item.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${item.prices}",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          widget.cartController.addToCart(item); // 🛒 Add product
                          Get.snackbar(
                            "Added to Cart",
                            "${item.name} has been added to your cart.",
                          );
                        },
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.red,
                          size: 18,
                        ),
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
  }
}
