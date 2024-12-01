import 'package:firebase_core/firebase_core.dart';

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return FirebaseOptions (
        apiKey: "AIzaSyCK-Fw6AwYKR12aAMoZc3jpi1IK-NtXq9E",
        authDomain: "sportsticket-34e51.firebaseapp.com",
        projectId: "sportsticket-34e51",
        storageBucket: "sportsticket-34e51.appspot.com",  // Corrected this to use proper Firebase storage URL
        messagingSenderId: "387235947855",
        appId: "1:387235947855:web:03dedc18076621b484513a",
        measurementId: "G-QNDX4R191L"
    );
  }
}
