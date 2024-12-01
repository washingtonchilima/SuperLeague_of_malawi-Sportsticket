import 'package:flutter/material.dart';
import 'confirmation_page.dart'; // Import ConfirmationPage

class PaymentPage extends StatelessWidget {
  final int totalCost;

  // Constructor to accept totalCost
  const PaymentPage({super.key, required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Payment Method',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Total Amount to Pay: K$totalCost', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Credit Card'),
              onTap: () {
                // Navigate to confirmation page after selecting payment method
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Mobile Wallet'),
              onTap: () {
                // Navigate to confirmation page after selecting payment method
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.paypal),
              title: const Text('PayPal'),
              onTap: () {
                // Navigate to confirmation page after selecting payment method
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
