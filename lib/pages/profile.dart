import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:otokhi/pages/payment_page.dart';
import 'address_page.dart';
import '../../widgets/contact_us.dart';
import '../../widgets/favorite.dart';
import '../../widgets/language.dart';
import '../../widgets/notifications.dart';
import '../../widgets/order_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _showLogoutModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // makes the blur visible
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Blurred background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            // Modal content
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              maxChildSize: 0.4,
              minChildSize: 0.3,
              builder: (_, controller) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Sure you want to log out?",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: StadiumBorder(),
                                side: BorderSide(color: Colors.blue),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                // Add your logout logic here
                                Navigator.pop(context);
                              },
                              child: Text("Yes. Logout",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Profile")),
      ),
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
                    // Profile Picture
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/product07.png'), // Add your image to assets
                    ),
                    SizedBox(width: 16),
                    // User Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kim757595',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Delivery to ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+855 99 84 84 75',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Menu Options
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  // Orders
                  ListTile(
                    leading: Icon(Icons.shopping_bag, color: Colors.blue),
                    title: Text('My Orders'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to orders screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderPage()));
                    },
                  ),
                  Divider(),
                  // Addresses
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.green),
                    title: Text('Saved Addresses'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to addresses screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddressesPage()));
                    },
                  ),
                  Divider(),
                  // Settings
                  ListTile(
                    leading: Icon(Icons.language, color: Colors.blue),
                    title: Text('Language'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to settings screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Language()));
                    },
                  ),
                  Divider(),
                  // Payment Methods
                  ListTile(
                    leading: Icon(Icons.payment, color: Colors.orange),
                    title: Text('Payment Methods'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to payment methods screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
                    },
                  ),
                  Divider(),
                  // Wishlist
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.red),
                    title: Text('Wishlist'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to wishlist screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteListScreen()));
                    },
                  ),

                  Divider(),
                  // Notifications
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.purple),
                    title: Text('Notifications'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to notifications screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                    },
                  ),
                  Divider(),
                  // Wishlist
                  ListTile(
                    leading: Icon(Icons.call, color: Colors.green),
                    title: Text('Contact Us'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to wishlist screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()));
                    },
                  ),
                  Divider(),
                  // Logout
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.grey),
                    title: Text('Logout'),
                    onTap: () => _showLogoutModal(context),
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







