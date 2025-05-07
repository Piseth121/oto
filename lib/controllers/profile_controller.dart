import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../services/profile_service.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  final profileService = ProfileService();
  final picker = ImagePicker();

  var profileImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    _loadStoredImage();
  }

  void _loadStoredImage() {
    final path = box.read('profile_image');
    if (path != null && File(path).existsSync()) {
      profileImage.value = File(path);
    }
  }

  Future<void> pickAndUploadImage() async {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take Photo'),
              onTap: () => _handleImagePick(ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () => _handleImagePick(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleImagePick(ImageSource source) async {
    Get.back(); // Close bottom sheet

    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    final token = box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'User token missing. Please login again.');
      return;
    }

    try {
      final response = await profileService.uploadProfileImage(file, token);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        box.write('profile_image', file.path);
        profileImage.value = file;

        Get.snackbar('Success', 'Profile image updated!');
      } else {
        Get.snackbar('Failed', data['message'] ?? 'Image upload failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Upload error: $e');
    }
  }

}
