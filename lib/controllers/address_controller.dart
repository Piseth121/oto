import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class AddressController extends GetxController {
  final box = GetStorage(); // Initialize storage

  // List of addresses
  var addressList = <Map<String, String>>[].obs;
  var selectedAddressIndex = (-1).obs;

  var defaultAddressIndex = RxnInt(); // Nullable int (Rx)

  // Text editing controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadAddresses(); // Load saved addresses at startup
  }

  void selectAddress(int index) {
    selectedAddressIndex.value = index;
  }

  Map<String, dynamic>? get selectedAddress {
    return selectedAddressIndex.value >= 0 && selectedAddressIndex.value < addressList.length
        ? addressList[selectedAddressIndex.value]
        : null;
  }

  void loadInitialData(Map<String, String>? data) {
    if (data != null) {
      nameController.text = data['name'] ?? '';
      phoneController.text = data['phone'] ?? '';
      streetController.text = data['street'] ?? '';
      cityController.text = data['city'] ?? '';
      zipController.text = data['zip'] ?? '';
    } else {
      clearForm();
    }
  }
  void clearSelection() {
    selectedAddressIndex.value = -1;
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    streetController.clear();
    cityController.clear();
    zipController.clear();
  }

  void addAddress() {
    final newAddress = {
      'name': nameController.text,
      'phone': phoneController.text,
      'street': streetController.text,
      'city': cityController.text,
      'zip': zipController.text,
    };
    addressList.add(newAddress);
    saveAddresses();
    clearForm();
  }

  void updateAddress(int index) {
    final updatedAddress = {
      'name': nameController.text,
      'phone': phoneController.text,
      'street': streetController.text,
      'city': cityController.text,
      'zip': zipController.text,
    };
    addressList[index] = updatedAddress;
    saveAddresses();
    addressList.refresh();
  }

  void deleteAddress(int index) {
    addressList.removeAt(index);
    saveAddresses();
  }
  void setDefaultAddress(int index) {
    defaultAddressIndex.value = index;

    // Load the selected address into form fields
    final selectedAddress = addressList[index];
    loadInitialData(selectedAddress);
    addressList.refresh();
    // Optional: save default permanently
    box.write('defaultIndex', index);
    Get.snackbar(
      'Default Address',
      'This address is now set as default.',
      backgroundColor: Colors.grey,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 50, left: 10, right: 10),
    );

  }

  void saveAddresses() {
    box.write('addresses', addressList);
    box.write('defaultIndex', defaultAddressIndex.value);
  }

  void loadAddresses() {
    List<dynamic>? storedAddresses = box.read<List>('addresses');
    if (storedAddresses != null) {
      addressList.assignAll(
          storedAddresses.map((e) => Map<String, String>.from(
              e.map((key, value) => MapEntry(key.toString(), value.toString()))
          )).toList()
      );
    }

    defaultAddressIndex.value = box.read<int>('defaultIndex');
  }


  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    zipController.dispose();
    super.onClose();
  }
}
