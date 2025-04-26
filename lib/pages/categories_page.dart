import 'package:flutter/material.dart';

import '../../constant_model/catigory.dart';
import '../../constant_model/new_product.dart';
import '../../constant_model/top_selling.dart';
import '../../widgets/item_card_2.dart';

class Categories extends StatefulWidget {
  //final NewProduct img;
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _selectedIndex = 0;

  List<String> name_category = [
    "For you",
    "ជើងរ៉ៃមានច្រវ៉ាក់",
    "គ្រឿងប្រដាប់ជាង",
    "ច្រវាក់និងកៅឡាក់",
    "ម៉ូទ័រយោង",
    "ខ្សែស្ទួច",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,size: 25,color: Colors.black,))
        ],
        backgroundColor: Colors.white,
      ),
      body:  Row(
        children: [
          // Vertical menu column
          Container(
            width: 120, // Fixed width for the menu
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: name_category.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Update the selected index
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index ? Colors.orange : Colors.transparent,
                      border: Border(
                        left: BorderSide(
                          color: _selectedIndex == index ? Colors.orange : Colors.transparent,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Text(
                      name_category[index],
                      style: TextStyle(
                        color: _selectedIndex == index ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold, fontFamily: "battambang",fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Display content based on the selected menu item
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  forYou(),
                  featured(),
                  gearedBeamTrolley(),
                  forYou(),
                  featured(),
                  gearedBeamTrolley(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget forYou(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
          child: Text("Recommendations", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        GridView.builder(
          itemCount: products.length,
          shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.70,
        ),
            itemBuilder: (context, index) => ItemCard2(product2: products[index])),
      ],
    );
  }
  Widget featured(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
          child: Text("Recommendations", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        GridView.builder(
            itemCount: topselling.length,
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) => ItemCard2(product2:topselling[index])),
      ],
    );
  }
  Widget gearedBeamTrolley(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
          child: Text("Recommendations", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        GridView.builder(
            itemCount: catigory.length,
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) => ItemCard2(product2: catigory[index])),
      ],
    );
  }

}

