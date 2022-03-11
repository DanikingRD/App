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
    final DocumentSnapshot<Map<String, dynamic>>snapshotData = await _getUserData();
    return FirestoreUser.fromDocumentSnapshot(snapshotData);
  }

  Future<Map<String, dynamic>> findDataFor(final String uid) async {
    final DocumentSnapshot<Map<String,dynamic>> document = await _getUserData();
    Map<String, dynamic>? data = document.data();
    if (data == null) {
      throw NullThrownError();
    }
    return data;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData() async {
     return _firestore
    .collection("users")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .get();
  }

  CollectionReference get users => _users;

}