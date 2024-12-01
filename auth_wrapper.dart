import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';  // Import LoginPage widget
import 'event_tickets_app.dart';  // Import EventTicketsApp widget

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth instance to check user login status
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());  // Show loading indicator while waiting
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));  // Show error if there is one
        } else if (snapshot.hasData) {
          return EventTicketsApp();  // User is logged in, navigate to EventTicketsApp
        } else {
          return LoginPage();  // User is not logged in, show LoginPage
        }
      },
    );
  }
}
