import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/pages/product_detail.dart';

import '../controllers/product_controller.dart';


class TopSellingPage extends StatelessWidget {
  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Selling Products')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: controller.topSolds.length,
          itemBuilder: (context, index) {
            var item = controller.topSolds[index];
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(proData: item))),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("\$${item.price}", style: TextStyle(color: Colors.red)),
                    ),
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
