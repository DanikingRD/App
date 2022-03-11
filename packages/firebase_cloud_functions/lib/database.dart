import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:firebase_cloud_functions/user/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseDatabase {
  
  final FirebaseFirestore _firestore;
  final CollectionReference _users;
  FirebaseDatabase(this._firestore) : _users = _firestore.collection("users");
  
  Future<FirestoreUser> getSignedInUser() async {
    DocumentSnapshot snapshot = await _firestore
    .collection("users")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .get();
    return FirestoreUser.fromDocumentSnapshot(snapshot);
  }

  CollectionReference get users => _users;

}