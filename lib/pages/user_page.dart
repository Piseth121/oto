import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: userController.userList.length,
          itemBuilder: (context, index) {
            final user = userController.userList[index];
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
              title: Text(user.name),
              subtitle: Text(user.email),
            );
          },
        );
      }),
    );
  }
}
