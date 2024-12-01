class Amount {
  final String id; // Unique ID for the entry
  final String category; // Category of the ticket (e.g., VIP, Open)
  final String description; // Description of the category
  final double price; // Price for the category
  final int available; // Number of tickets available in this category

  Amount({
    required this.id,
    required this.category,
    required this.description,
    required this.price,
    required this.available,
  });

  // Factory method to create an Amount instance from Firestore document data
  factory Amount.fromFirestore(Map<String, dynamic> data, String id) {
    return Amount(
      id: id,
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      available: (data['available'] ?? 0),
    );
  }
}
