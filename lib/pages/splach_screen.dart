import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otokhi/pages/get_started_page.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {


  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds then navigate to HomePage
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStartedPage()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Image.asset("assets/icons/logo.png", fit: BoxFit.cover,)),
            SizedBox(height: 20,),
            Text("Welcome to OTOKHI", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            CircularProgressIndicator(),
        ],
        ),
      ),
    );
  }
}
