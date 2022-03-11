

import 'package:cloud_firestore/cloud_firestore.dart';

/// Defines a [FirebaseUser].
/// This is typically used for Auth listening and
/// only gives you the "uid" and "email" that user signed in is using.
class FirebaseUser {
  final String uid;
  final String email;

  const FirebaseUser({required this.uid, required this.email});
}
// Defines a [FirestoreUser].
// Contains all the properties of the user's document in the Firestore database
class FirestoreUser {
  final String uid;
  final String email;
  final String avatarURL;

  const FirestoreUser({
    required this.uid,
    required this.email,
    required this.avatarURL,
  });


  factory FirestoreUser.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return FirestoreUser.fromJson(data);
  }

  factory FirestoreUser.fromJson(Map<String, dynamic> json) {
    return FirestoreUser(
      uid: json["uid"],
      email: "email",
      avatarURL: "avatarURL",
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "avatarURL": avatarURL,
  };

  
}
