import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otokhi/pages/signup_page.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final authController = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),centerTitle: true,),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Welcome to OTOKHI",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange[700]),
              ),
              SizedBox(height: 32),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  authController.login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Login",
                    style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Get.to(SignUpPage()),
                    child: Text(" Sign Up",style: TextStyle(color: Colors.blue),),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Center(child: Text('Or')),
              SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                }, label: Row(
                  children: [
                    Image.asset('assets/icons/google.png',height: 20,width: 20,fit: BoxFit.cover,),
                    SizedBox(width: 50,),
                    Text('Sign in with Google'),
                  ],
                ),),
              ElevatedButton.icon(
                onPressed: () {
                }, label: Text('Sign in FaceBook'),),
            ],
          ),
        ),
      ),
    );
  }
}

