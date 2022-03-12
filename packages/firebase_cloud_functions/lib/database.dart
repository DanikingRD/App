import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_cloud_functions/user/user.dart';

class FirebaseDatabase {
  
  final FirebaseFirestore _firestore;
  final CollectionReference _users;
  FirebaseDatabase(this._firestore) : _users = _firestore.collection("users");
  
  Future<FirestoreUser> getUserModel(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>>snapshotData = await _getUserData(uid);
    return FirestoreUser.fromDocumentSnapshot(snapshotData);
  }

  Future<Map<String, dynamic>> findAccountData(final String uid) async {
    final DocumentSnapshot<Map<String,dynamic>> document = await _getUserData(uid);
    return document.data()!;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData(final String uid) async {
     return _firestore
    .collection("users")
    .doc(uid)
    .get();
  }

  CollectionReference get users => _users;

}