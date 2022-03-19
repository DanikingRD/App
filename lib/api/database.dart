import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_card_app/model/preferences.dart';
import 'package:digital_card_app/model/user.dart';

class FirestoreAPI {
  final CollectionReference preferences =
      FirebaseFirestore.instance.collection("preferences");
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Stream<UserPreferences> streamPreferences(String id) {
    return _instance
        .collection("preferences")
        .doc(id)
        .snapshots()
        .map((event) => UserPreferences.fromJson(event.data()!));
  }

  Stream<TapeaUser> streamUser(String id) {
    return _instance
        .collection("users")
        .doc(id)
        .snapshots()
        .map((event) => TapeaUser.fromJson(event.data()!));
  }

  Future<Map<String, dynamic>> readSingle({
    required String collection,
    required String uid,
  }) async {
    final json = await _instance.collection(collection).doc(uid).get();
    return json.data()!;
  }

  Future<TapeaUser> readUser(String id) async {
    final json = await readSingle(collection: "users", uid: id);
    return TapeaUser.fromJson(json);
  }

  Future<UserPreferences> readPreferences(String id) async {
    final json = await readSingle(collection: "preferences", uid: id);
    return UserPreferences.fromJson(json);
  }

  Future<void> writeSingle({
    required String path,
    required String collection,
    required Map<String, dynamic> json,
  }) async {
    return await _instance.collection(collection).doc(path).set(json);
  }

  Future<void> updateSingle({
    required String collection,
    required String uid,
    required String key,
    required dynamic value,
  }) async {
    return await _instance.collection(collection).doc(uid).update({
      key: value,
    });
  }

  FirebaseFirestore get instance => _instance;
}
