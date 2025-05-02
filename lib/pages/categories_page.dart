import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/controllers/product_controller.dart';

class Categories extends StatefulWidget {
  Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final ProductController controller = Get.find<ProductController>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border, size: 25, color: Colors.black),
          ),
        ],
      ),
      body: Obx(() {
        final categories = controller.categories;
        if (categories.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return Row(
          children: [
            // Left-side category tab
            Container(
              width: 120,
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return GestureDetector(
                    onTap: () {
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
                        cat['name'],
                        style: TextStyle(
                          color: _selectedIndex == index ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "battambang",
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Right-side product grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: _buildCategoryProducts(categories[_selectedIndex]['id']),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCategoryProducts(int categoryId) {
    final items = controller.productsByCategory[categoryId] ?? [];

    if (items.isEmpty) {
      return Center(child: Text("No products available in this category."));
    }

    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: CircleBorder(),
                elevation: 5,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: item.images.isNotEmpty
                      ? NetworkImage(item.images[0])
                      : AssetImage('assets/images/no_image.png') as ImageProvider,
                ),
              ),
              SizedBox(height: 10),
              Text(
                item.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "battambang"),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
             
              Text(
                "\$${item.price.toString()}",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        );
      },
    );
  }

}
