import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Pages/product_detail.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final ProductController productController = Get.find<ProductController>();
  final RxString searchQuery = ''.obs;

  List<Product> get searchResults {
    final q = searchQuery.value.toLowerCase();
    return productController.products.where((product) {
      return product.name.toLowerCase().contains(q) ||
          product.category.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         title: Container(
           padding: EdgeInsets.symmetric(horizontal: 12),
           decoration: BoxDecoration(
             border: Border.all(color: Colors.grey.shade300),
             borderRadius: BorderRadius.circular(25),
             color: Colors.grey.shade100,
           ),
           child: TextField(
             onChanged: (value) => searchQuery.value = value,
             decoration: InputDecoration(
               icon: Icon(Icons.search, color: Colors.grey),
               hintText: 'Search by name or category...',
               border: InputBorder.none,
             ),
           ),
         ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                final results = searchResults;
                if (results.isEmpty) {
                  return Center(child: Text('No matching products found'));
                }
                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final product = results[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: product.images.isNotEmpty
                            ? Image.network(product.images[0], width: 60, height: 60, fit: BoxFit.cover)
                            : Image.asset('assets/images/no_image.png', width: 60, height: 60),
                      ),
                      title: Text(product.name, style: TextStyle(fontFamily: "battambang")),
                      subtitle: Text(product.category, style: TextStyle(fontFamily: "battambang")),
                      onTap: () => Get.to(() => DetailPage(proData: product)),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
