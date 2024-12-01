import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/game.dart';

class GameService {
  // Method to save a game to Firestore
  Future<void> addGame(String title, String description, DateTime date, String formattedDate) async {
    final gamesCollection = FirebaseFirestore.instance.collection('games');
    await gamesCollection.add({
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),  // Store as Timestamp
      'formattedDate': formattedDate,   // Store as formatted String
    });
  }

  // Method to fetch upcoming games from Firestore
  Future<List<Game>> getUpcomingGames() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('games')
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs.map((doc) => Game.fromFirestore(doc)).toList();
  }
}
