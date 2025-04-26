import 'package:flutter/material.dart';
import 'package:otokhi/Pages/profile.dart';
import 'cart_page.dart';
import 'categories_page.dart';
import 'home_page.dart';
import 'messenger_page.dart';


class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: _buildBody(),
          bottomNavigationBar: _buildBottom(),
        ));
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        HomePage(),
        Categories(),
        Messenger(),
        CartPage(),
        Profile(),
      ],
    );
  }

  int _currentIndex = 0;

  Widget _buildBottom() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.messenger_outline),
          label: 'Messenger',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        // Handle navigation
      },
    );
  }

}
