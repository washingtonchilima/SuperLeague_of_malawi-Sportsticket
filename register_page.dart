import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/profile.dart';  // Correct import for profile.dart in models directory

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController profileImageURLController = TextEditingController();

  Future<void> register(BuildContext context) async {
    try {
      // Create user
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Create the profile object
      Profile profile = Profile(
        id: userCredential.user!.uid,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        dateOfBirth: dateOfBirthController.text.trim(),
        bio: bioController.text.trim(),
        profileImageURL: profileImageURLController.text.trim(),  // Use actual image URL later
      );

      // Save profile to Firestore
      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userCredential.user!.uid)
          .set(profile.toMap());

      // Redirect to LoginPage
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      // Handle registration error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration Failed'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
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
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: dateOfBirthController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            TextField(
              controller: profileImageURLController,
              decoration: InputDecoration(labelText: 'Profile Image URL'),
            ),
            ElevatedButton(
              onPressed: () => register(context),
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
