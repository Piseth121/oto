import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/address_controller.dart';

class AddAddressPage extends StatelessWidget {
  final AddressController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final int? editIndex; // null if adding new

  AddAddressPage({Key? key, this.editIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editIndex == null ? 'Add Address' : 'Edit Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(controller.nameController, 'Full Name'),
              SizedBox(height: 12),
              _buildTextField(controller.phoneController, 'Phone Number', keyboardType: TextInputType.phone),
              SizedBox(height: 12),
              _buildTextField(controller.streetController, 'Street Address'),
              SizedBox(height: 12),
              _buildTextField(controller.cityController, 'City'),
              SizedBox(height: 12),
              _buildTextField(controller.zipController, 'Zip Code', keyboardType: TextInputType.number),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (editIndex == null) {
                      controller.addAddress();
                    } else {
                      controller.updateAddress(editIndex!);
                    }
                    Get.back(); // go back after saving
                  }
                },
                child: Text('Save Address', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
