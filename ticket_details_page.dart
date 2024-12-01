import 'package:flutter/material.dart';
import 'ticket_selection_page.dart';

class TicketDetailsPage extends StatelessWidget {
  final Map<String, String> eventData;

  const TicketDetailsPage({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ticket Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[700],
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  eventData['imageUrl']!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                eventData['title']!,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              const SizedBox(height: 8),

              // Venue and Time
              Card(
                color: Colors.teal[50],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.teal),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Venue: ${eventData['venue']!}',
                              style: const TextStyle(fontSize: 18),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.teal),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Time: ${eventData['time']!}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              Card(
                color: Colors.teal[50],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Event Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        eventData['description']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.teal[700],
                      side: BorderSide(color: Colors.teal.shade700, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketSelectionPage(eventTitle: eventData['title']!, eventId: '',),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Proceed'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
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
