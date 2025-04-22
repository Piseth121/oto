import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/pages/slideshow.dart';
import '../../constant_model/models.dart';
import '../../constant_model/new_product.dart';
import '../../constant_model/top_selling.dart';
import '../../widgets/itme_card_1.dart';
import '../../widgets/search_page.dart';
import '../controllers/cart_controller.dart';
import 'detail_page.dart';

class HomeProduct extends StatefulWidget {
  HomeProduct({super.key});
  final CartController cartController = Get.put(CartController());

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {

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
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 10, color: Colors.black26),
            hintText: "Search here",
          ),
          obscureText: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
      ),
    );
  }

  Widget _newProducts() {
    return Container(
      color: Colors.white,
      // height: 300,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
              ],
            ),
          ),
          SizedBox(height: 5),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(children: [_buildPro()]),
          ),
        ],
      ),
    );
  }

  Widget _buildPro() {

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildNewProItem(products[index]);
        },
      ),
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
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,);
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

  Widget _topSelling() {
    return Container(
      color: Colors.white,
      // height: 300,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Selling',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
              ],
            ),
          ),
          SizedBox(height: 5),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(children: [_buildTop()]),
          ),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: topselling.length,
        itemBuilder: (context, index) {
          return _buildNewTopItem(topselling[index]);
        },
      ),
    );
  }

  Widget _buildNewTopItem(NewProduct item) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
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
                Row(
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
                      onPressed: () {},
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
      ),
    );
  }

  Widget _buildForYou() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended For You',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              childAspectRatio: 0.70,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) => ItemCard(pro: products[index]),
          ),
        ),
      ],
    );
  }
}
