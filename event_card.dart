import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Map<String, String> eventData; // Argument to pass event data

  const EventCard({Key? key, required this.eventData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              eventData['imageUrl']!, // Use eventData for all values
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventData['title']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    eventData['description']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text('Venue: ${eventData['venue']!}'),
                  Text('Time: ${eventData['time']!}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
