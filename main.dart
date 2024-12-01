import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebaseoptions.dart'; // Corrected to match the file name casing
import 'login_page.dart';
import 'register_page.dart';
import 'event_tickets_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // Ensure this is correct
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Tickets App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),  // Login page as the initial screen
        '/register': (context) => RegisterPage(),  // Register page route
        '/home': (context) => EventTicketsApp(),  // Event tickets main app
      },
    );
  }
}
