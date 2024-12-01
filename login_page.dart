import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'event_tickets_app.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      // Attempt to sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // If login is successful, navigate to EventTicketsApp
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EventTicketsApp()),
      );
    } catch (e) {
      // Handle login error
      print('Login Error: $e');
      // You can show an error message to the user here
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid email or password'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () => login(context), // Trigger login function
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register'); // Navigate to RegisterPage
              },
              child: Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
