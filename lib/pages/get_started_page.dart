import 'package:flutter/material.dart';
import 'package:otokhi/pages/main_page.dart';
import 'sign_in_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo or image
            Image.asset(
              'assets/icons/logo.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 30),
            // Title
            const Text(
              'Welcome to MyApp',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Description
            const Text(
              'Your one-stop app for everything.\nLet’s get started!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 50),
            // Get Started Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue,
                    ),
                      onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignInPage()),
                    );
                  }, child: const Text('Sign in')),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainPage()),
                      );
                    },
                    child: const Text('Get Started'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


