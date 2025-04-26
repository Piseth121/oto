import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/address_controller.dart';
import '../widgets/add_address_page.dart';

class AddressesPage extends StatelessWidget {
  final AddressController controller = Get.put(AddressController());

  AddressesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              controller.clearSelection();
              Get.back();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Implement search functionality
              controller.clearForm(); // Clear form for new entry
              Get.to(() => AddAddressPage());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.addressList.isEmpty) {
          return Center(child: Text('No address found.'));
        }
        return ListView.builder(
          itemCount: controller.addressList.length,
          itemBuilder: (context, index) {
            final address = controller.addressList[index];
            final isSelected = controller.selectedAddressIndex.value == index;
            return GestureDetector(
              onTap: () {
                controller.selectAddress(index);
                Get.back(result: controller.addressList[index]); // Return selected address when tapped
                controller.saveAddresses();
              },

              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: isSelected ? Colors.blue.shade50 : Colors.white,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (isSelected)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(Icons.check_circle, color: Colors.blue),
                            ),
                          Text(
                            address['name'] ?? '',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            address['phone'] ?? '',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${address['street'] ?? ''}, ${address['city'] ?? ''}, ${address['zip'] ?? ''}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (controller.defaultAddressIndex.value == index)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '✓ Default',
                                style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold),
                              ),
                            )
                          else
                            TextButton.icon(
                              onPressed: () => controller.setDefaultAddress(index),
                              icon: Icon(Icons.check_circle_outline, color: Colors.grey),
                              label: Text('Make Default'),
                            ),
                          SizedBox(width: 8),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              controller.loadInitialData(address);
                              Get.to(() => AddAddressPage(editIndex: index));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(index),
                          ),
                        ],
                      ),
              
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              controller.clearForm(); // Clear form for new entry
              Get.to(() => AddAddressPage());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Add Address',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),

    );
  }

  void _confirmDelete(int index) {
    Get.defaultDialog(
      title: 'Delete Address',
      middleText: 'Are you sure you want to delete this address?',
      textCancel: 'Cancel',
      cancelTextColor: Colors.black,
      textConfirm: 'Delete',
      buttonColor: Colors.red,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.find<AddressController>().deleteAddress(index);
        Get.back(); // Close dialog
      },
    );
  }
}
