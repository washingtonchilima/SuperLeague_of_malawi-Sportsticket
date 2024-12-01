import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String id;
  String name;
  String email;
  String dateOfBirth;
  String bio;
  String profileImageURL;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.bio,
    required this.profileImageURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'bio': bio,
      'profileImageURL': profileImageURL,
    };
  }

  factory Profile.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Profile(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      dateOfBirth: data['dateOfBirth'],
      bio: data['bio'],
      profileImageURL: data['profileImageURL'],
    );
  }
}
