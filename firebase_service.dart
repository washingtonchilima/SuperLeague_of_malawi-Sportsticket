import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/amount.dart';
import '../models/game.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new game with its ticket categories
  Future<void> addGameWithTickets({
    required String gameId,
    required String title,
    required String description,
    required DateTime date,
    required String formattedDate,
    required List<Amount> tickets,
  }) async {
    final gameRef = _firestore.collection('games').doc(gameId);

    // Save game details
    await gameRef.set({
      'title': title,
      'description': description,
      'date': date,
      'formattedDate': formattedDate,
    });

    // Save ticket categories in the `amounts` sub-collection
    final ticketRef = gameRef.collection('amounts');
    for (final ticket in tickets) {
      await ticketRef.doc(ticket.id).set({
        'category': ticket.category,
        'description': ticket.description,
        'price': ticket.price,
        'available': ticket.available,
      });
    }
  }

  // Fetch tickets for a specific game
  Future<List<Amount>> fetchAmountsForGame(String gameId) async {
    final querySnapshot = await _firestore
        .collection('games')
        .doc(gameId)
        .collection('amounts')
        .get();

    return querySnapshot.docs
        .map((doc) => Amount.fromFirestore(doc.data(), doc.id))
        .toList();
  }
}
