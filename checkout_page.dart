import 'package:flutter/material.dart';
import 'payment_page.dart';

class CheckoutPage extends StatelessWidget {
  final Map<String, bool> selectedTicketTypes;
  final int ticketQuantity;

  const CheckoutPage({
    super.key,
    required this.selectedTicketTypes,
    required this.ticketQuantity,
  });

  @override
  Widget build(BuildContext context) {
    int totalCost = 0;
    // Define prices
    const generalPrice = 2000;
    const vipPrice = 5000;
    const earlyBirdPrice = 2500;

    // Calculate total cost based on selected ticket types
    if (selectedTicketTypes['General'] == true) totalCost += generalPrice * ticketQuantity;
    if (selectedTicketTypes['VIP'] == true) totalCost += vipPrice * ticketQuantity;
    if (selectedTicketTypes['Early Bird'] == true) totalCost += earlyBirdPrice * ticketQuantity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ticket Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Quantity: $ticketQuantity'),
            const SizedBox(height: 8),
            ...selectedTicketTypes.entries
                .where((entry) => entry.value)
                .map((entry) => Text('${entry.key}: Yes'))
                .toList(),
            const SizedBox(height: 16),
            Text('Total Cost: K$totalCost', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Pass the totalCost to the PaymentPage and navigate
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      totalCost: totalCost,
                    ),
                  ),
                );
              },
              child: const Text('Proceed to Payment'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[700]),
            ),
          ],
        ),
      ),
    );
  }
}
