import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPersonalData();
  }

  Future<void> _loadPersonalData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('profiles')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          // Populate controllers with fetched data
          setState(() {
            nameController.text = userDoc['name'] ?? '';
            emailController.text = userDoc['email'] ?? currentUser.email ?? '';
            dobController.text = userDoc['dateOfBirth'] ?? '';
            bioController.text = userDoc['bio'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error loading personal data: $e');
    }
  }

  Future<void> _savePersonalData() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Update Firestore with new data
        await FirebaseFirestore.instance
            .collection('profiles')
            .doc(currentUser.uid)
            .update({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'dateOfBirth': dobController.text.trim(),
          'bio': bioController.text.trim(),
        });

        // Provide feedback to user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Personal data updated successfully!')),
        );
      }
    } catch (e) {
      print('Error saving personal data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update data!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Data'),
        backgroundColor: const Color(0xFF1A1A2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                value!.isEmpty ? 'Name cannot be empty' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                value!.isEmpty ? 'Email cannot be empty' : null,
              ),
              TextFormField(
                controller: dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
              ),
              TextFormField(
                controller: bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Cancel and go back
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _savePersonalData,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
