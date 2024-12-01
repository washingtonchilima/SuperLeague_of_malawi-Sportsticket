import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsticket/personaldata.dart';
import 'package:sportsticket/accsettings.dart';
import 'package:sportsticket/event_tickets_home_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String name = 'Loading...';
  String email = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Retrieve email from FirebaseAuth
        email = currentUser.email ?? 'No Email';

        // Fetch additional user details from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('profiles')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            name = userDoc['name'] ?? 'Your Name'; // Fetch 'name' from Firestore
          });
        } else {
          setState(() {
            name = 'Your Name';
          });
        }
      }
    } catch (e) {
      setState(() {
        name = 'Error fetching name';
        email = 'Error fetching email';
      });
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const EventTicketsHomePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.teal[700],
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: const Text('Personal Data', style: TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalDataScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.white),
                    title: const Text('Account Settings', style: TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountSettingsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.event, color: Colors.white),
                    title: const Text('Event log', style: TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.language, color: Colors.white),
                    title: const Text('Language', style: TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.white),
                    title: const Text('Support details', style: TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.white),
                    title: const Text('Delete account', style: TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: const Text('Log out', style: TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            const Center(
              child: Column(
                children: [
                  Text(
                    'TERMS AND CONDITIONS OF USE',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'PRIVACY POLICY AND COOKIE NOTICE',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Version: 1.39.3',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
