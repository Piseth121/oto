import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/widgets/accessories_page.dart';
import 'package:otokhi/widgets/geared_beam_trolley.dart';

class SearchController extends GetxController {
  var query = ''.obs;
  var items = [
    'គ្រឿងប្រដាប់ជាង',
    'ច្រវាក់និងកៅឡាក់',
    'ម៉ូទ័រយោង',
    'ខ្សែស្ទួច',
  ].obs;

  List<String> get filteredItems => items
      .where((item) => item.toLowerCase().contains(query.value.toLowerCase()))
      .toList();
}

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final SearchController controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Products')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.query.value = value,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                final results = controller.filteredItems;
                if (results.isEmpty) {
                  return Center(child: Text('No results found'));
                }
                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.disabled_by_default, color: Colors.grey),
                      title: Text(
                        results[index],
                        style: TextStyle(fontFamily: "battambang", fontSize: 16),
                      ),
                      onTap: () {
                        final item = results[index];
                        if (item == 'គ្រឿងប្រដាប់ជាង') {
                          Get.to(() => AccessoriesPage());
                        } else if (item == 'ច្រវាក់និងកៅឡាក់') {
                          Get.to(() => GearedBeamTrolley());
                        } else {
                          // Default or fallback
                          Get.snackbar('Not found', 'No page set for this item');
                        }
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
