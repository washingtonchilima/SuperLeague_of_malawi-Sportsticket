import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Thank you for your purchase. Your tickets will be sent to your email shortly.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home page or initial screen
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Back to Home'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
