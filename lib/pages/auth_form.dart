import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final String title;
  final String buttonText;
  final String switchText;
  final VoidCallback onSwitch;
  final VoidCallback onSubmit;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthForm({
    required this.title,
    required this.buttonText,
    required this.switchText,
    required this.onSwitch,
    required this.onSubmit,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.orange)),
                SizedBox(height: 24),
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
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(buttonText, style: TextStyle(fontSize: 16,color: Colors.white)),
                ),
                TextButton(
                  onPressed: onSwitch,
                  child: Text(switchText),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
