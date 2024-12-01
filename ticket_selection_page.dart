import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/amount.dart';

class TicketSelectionPage extends StatefulWidget {
  final String eventTitle;
  final String eventId;

  const TicketSelectionPage({
    super.key,
    required this.eventTitle,
    required this.eventId,
  });

  @override
  _TicketSelectionPageState createState() => _TicketSelectionPageState();
}

class _TicketSelectionPageState extends State<TicketSelectionPage> {
  late Future<List<Map<String, dynamic>>> _ticketCategoriesFuture;

  final Map<String, int> _selectedTickets = {};

  @override
  void initState() {
    super.initState();
    _ticketCategoriesFuture = _fetchTicketCategories();
  }

  Future<List<Map<String, dynamic>>> _fetchTicketCategories() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventId)
        .get();

    final data = snapshot.data()!;
    return List<Map<String, dynamic>>.from(data['ticketCategories']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.eventTitle} - Tickets'),
        backgroundColor: Colors.teal[700],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _ticketCategoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load ticket categories.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No ticket categories available.'));
          }

          final ticketCategories = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: ticketCategories.length,
            itemBuilder: (context, index) {
              return _buildAmountCard(context, ticketCategories[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildAmountCard(BuildContext context, Map<String, dynamic> category) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: const Icon(Icons.event_seat, color: Colors.white),
        ),
        title: Text(
          category['category'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${category['description']}\nPrice: K${category['price'].toString()}\nAvailable: ${category['available']}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            _showQuantitySelector(category);
          },
        ),
      ),
    );
  }

  void _showQuantitySelector(Map<String, dynamic> category) {
    int selectedQuantity = _selectedTickets[category['category']] ?? 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Quantity for ${category['category']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Price: K${category['price']}'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: selectedQuantity > 0
                        ? () {
                      setState(() {
                        selectedQuantity--;
                      });
                    }
                        : null,
                  ),
                  Text('$selectedQuantity', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: selectedQuantity < category['available']
                        ? () {
                      setState(() {
                        selectedQuantity++;
                      });
                    }
                        : null,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Confirm'),
              onPressed: () {
                setState(() {
                  if (selectedQuantity > 0) {
                    _selectedTickets[category['category']] = selectedQuantity;
                  } else {
                    _selectedTickets.remove(category['category']);
                  }
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
