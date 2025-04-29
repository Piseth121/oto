import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/pages/new_products_page.dart';
import 'package:otokhi/pages/product_detail.dart';
import 'package:otokhi/pages/recommended_page.dart';
import 'package:otokhi/pages/top_selling_page.dart';
import 'package:otokhi/widgets/search_page.dart';
import 'package:otokhi/widgets/slideshow.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../widgets/loading_skeleton.dart';


class HomeProduct extends StatefulWidget {
  HomeProduct({super.key});

  final CartController cartController = Get.put(CartController());

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _search(),
        Slide_Show(),
        SizedBox(height: 10),
        _newProducts(),
        SizedBox(height: 10),
        _topSelling(),
        SizedBox(height: 10),
        _buildForYou(),
      ],
    );
  }

  Widget _search() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search here",
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage())),
        ),
      ),
    );
  }

  Widget _newProducts() {
    return _section("New Products", () => NewProductsPage(), controller.newProducts);
  }

  Widget _topSelling() {
    return _section("Top Selling", () => TopSellingPage(), controller.topSelling);
  }

  Widget _buildForYou() {
    return Column(
      children: [
        _sectionHeader("Recommended For You", () => RecommendedPage()),
        Padding(
          padding: EdgeInsets.all(10),
          child: Obx(() {
            if (controller.isLoading.value) {
              return GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.70, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemBuilder: (context, index) => ShimmerBox(width: double.infinity, height: 220),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.recommendeds.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.70, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemBuilder: (context, index) => _buildItemCard(controller.recommendeds[index]),
            );
          }),
        ),
      ],
    );
  }

  Widget _section(String title, Widget Function() nextPage, var list) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _sectionHeader(title, nextPage),
          SizedBox(height: 5),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              if (controller.isLoading.value) {
                return Row(children: List.generate(4, (index) => ShimmerBox(width: 150, height: 220)));
              }
              return Row(
                children: List.generate(
                  list.length,
                      (index) => _buildItemCard(list[index]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, Widget Function()? nextPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (nextPage != null)
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage())),
            ),
        ],
      ),
    );
  }

  Widget _buildItemCard(item) {
    return Obx(() {
      if (widget.cartController.isLoading.value) {
        return ShimmerBox(width: 150, height: 220);
      }
      return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPageP(proData: item)));
          },
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
                          image: item.images != null && item.images.isNotEmpty
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
                            widget.cartController.addToCart(item);
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
