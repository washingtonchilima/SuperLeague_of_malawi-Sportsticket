import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddTicketPage extends StatefulWidget {
  const AddTicketPage({super.key});

  @override
  State<AddTicketPage> createState() => _AddTicketPageState();
}

class _AddTicketPageState extends State<AddTicketPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController venueController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // List of categories entered by the user
  List<Map<String, String>> ticketCategories = [];

  // Controllers for ticket category fields
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController categoryDescriptionController = TextEditingController();
  final TextEditingController categoryPriceController = TextEditingController();
  final TextEditingController categoryAvailableController = TextEditingController();

  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final dateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        timeController.text = DateFormat("d MMMM yyyy at HH:mm:ss", "en_US").format(dateTime);
      }
    }
  }

  // Add a new category to the ticket
  void _addCategory() {
    final category = categoryController.text.trim();
    final description = categoryDescriptionController.text.trim();
    final price = categoryPriceController.text.trim();
    final available = categoryAvailableController.text.trim();

    if (category.isEmpty || description.isEmpty || price.isEmpty || available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all category fields')),
      );
      return;
    }

    setState(() {
      ticketCategories.add({
        'category': category,
        'description': description,
        'price': price,
        'available': available,
      });
      // Clear input fields for the next category
      categoryController.clear();
      categoryDescriptionController.clear();
      categoryPriceController.clear();
      categoryAvailableController.clear();
    });
  }

  void _addTicket(BuildContext context) {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final venue = venueController.text.trim();
    final imageUrl = imageUrlController.text.trim();
    final timeText = timeController.text.trim();

    if (title.isEmpty || description.isEmpty || venue.isEmpty || imageUrl.isEmpty || timeText.isEmpty || ticketCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields and add at least one category')),
      );
      return;
    }

    try {
      final DateTime time = DateFormat("d MMMM yyyy at HH:mm:ss", "en_US").parse(timeText);
      final Timestamp timestamp = Timestamp.fromDate(time);

      // Add ticket event with categories
      FirebaseFirestore.instance.collection('events').add({
        'title': title,
        'description': description,
        'venue': venue,
        'imageUrl': imageUrl,
        'time': timestamp,
        'ticketCategories': ticketCategories,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ticket added successfully')),
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add ticket: $error')),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid date/time format.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ticket'),
        backgroundColor: Colors.teal[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            TextField(
              controller: venueController,
              decoration: const InputDecoration(labelText: 'Venue'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: timeController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Time (tap to select)',
              ),
              onTap: _pickDateTime,
            ),
            const SizedBox(height: 20),

            // Ticket Categories Section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Ticket Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: categoryDescriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: categoryPriceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: categoryAvailableController,
              decoration: const InputDecoration(labelText: 'Available'),
            ),
            ElevatedButton(
              onPressed: _addCategory,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
              ),
              child: const Text('Add Category'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addTicket(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
              ),
              child: const Text('Add Ticket'),
            ),
          ],
        ),
      ),
    );
  }
}
