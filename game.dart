import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String formattedDate;

  Game({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.formattedDate,
  });

  // Factory method to create a Game instance from Firestore document
  factory Game.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Game(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      formattedDate: data['formattedDate'] ?? '',
    );
  }
}
