import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'payment_page.dart';
import 'address_page.dart';
import 'sign_in_page.dart';
import 'order_page.dart';
import '../../widgets/contact_us.dart';
import '../../widgets/favorite.dart';
import '../../widgets/language.dart';
import '../../widgets/notifications.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final box = GetStorage();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  void _loadProfileImage() async {
    final storedPath = box.read('profile_image');
    if (storedPath != null && File(storedPath).existsSync()) {
      setState(() {
        _profileImage = File(storedPath);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/profile.png');

      box.write('profile_image', savedImage.path);

      setState(() {
        _profileImage = savedImage;
      });
    }
  }

  void _showLogoutModal() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Logout", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                SizedBox(height: 15),
                Text("Sure you want to log out?", style: TextStyle(fontSize: 16)),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(shape: StadiumBorder(), side: BorderSide(color: Colors.blue)),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel", style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: StadiumBorder(), backgroundColor: Colors.red),
                        onPressed: () {
                          box.erase(); // clear all storage
                          Get.offAll(() => SignInPage());
                        },
                        child: Text("Yes. Logout", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = box.read('isLoggedIn') ?? false;
    final user = box.read('user');

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Profile"))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.blue[50],
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isLoggedIn) _pickImage(); // Allow image change only if logged in
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: isLoggedIn
                            ? (_profileImage != null
                            ? FileImage(_profileImage!)
                            : AssetImage('assets/images/default_user.png') as ImageProvider)
                            : AssetImage('assets/images/guest.png'),
                      ),
                    ),

                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isLoggedIn ? (user?['name'] ?? 'User') : 'Guest',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          isLoggedIn ? 'Welcome back!' : 'Please sign in to continue',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        if (isLoggedIn && user?['phone'] != null)
                          Text(user['phone'], style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Menu
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.shopping_bag, color: Colors.blue),
                    title: Text('My Orders'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      isLoggedIn
                          ? Navigator.push(context, MaterialPageRoute(builder: (_) => MyOrderPage()))
                          : Get.to(() => SignInPage());
                    },
                  ),
                  Divider(),

                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.green),
                    title: Text('Saved Addresses'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      isLoggedIn
                          ? Navigator.push(context, MaterialPageRoute(builder: (_) => AddressesPage()))
                          : Get.to(() => SignInPage());
                    },
                  ),
                  Divider(),

                  ListTile(
                    leading: Icon(Icons.language, color: Colors.blue),
                    title: Text('Language'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LanguagePage())),
                  ),
                  Divider(),

                  ListTile(
                    leading: Icon(Icons.payment, color: Colors.orange),
                    title: Text('Payment Methods'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      isLoggedIn
                          ? Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentPage()))
                          : Get.to(() => SignInPage());
                    },
                  ),
                  Divider(),

                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.red),
                    title: Text('Wishlist'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      isLoggedIn
                          ? Navigator.push(context, MaterialPageRoute(builder: (_) => FavoriteListScreen()))
                          : Get.to(() => SignInPage());
                    },
                  ),
                  Divider(),

                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.purple),
                    title: Text('Notifications'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationPage())),
                  ),
                  Divider(),

                  ListTile(
                    leading: Icon(Icons.call, color: Colors.green),
                    title: Text('Contact Us'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactUs())),
                  ),
                  Divider(),

                  if (isLoggedIn)
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.grey),
                      title: Text('Logout'),
                      onTap: () => _showLogoutModal(),
                    ),

                  if (!isLoggedIn)
                    ListTile(
                      leading: Icon(Icons.login, color: Colors.orange),
                      title: Text('Sign In'),
                      onTap: () => Get.to(() => SignInPage()),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
