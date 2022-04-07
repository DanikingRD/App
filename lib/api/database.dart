import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_card_app/model/card.dart';
import 'package:digital_card_app/model/user.dart';

class FirestoreAPI {

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final FirebaseFirestore _instance = FirebaseFirestore.instance;


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
  //   try {
  //     return json.data()!;
  //   } on Exception catch (e) {

  //   }; 
  // }

  // Future<List<Map<String, dynamic>>> readCards({required String id}) async {
  //   final query =
  //       await _instance.collection("profiles").doc(id).collection("devices").get();
  //   final List<Map<String, dynamic>> docs = [];
  //   for (var doc in query.docs) {
  //     docs.add(doc.data());
  //   }
  //   return docs;
  // }

  Future<void> writeCard({
    required String id,
    required String cardTitle,
    required Map<String, dynamic> json,
  }) async {
    _instance
        .collection("profiles")
        .doc(id)
        .collection("devices")
        .doc(cardTitle)
        .set(json);
  }

  Future<TapeaCard> readCard({
    required String uid,
    required String cardTitle,
  }) async {
    final json = await _instance
    .collection("profiles")
    .doc(uid)
    .collection("devices")
    .doc(cardTitle)
    .get();
    return TapeaCard.fromJson(json.data()!);
  }

  Future<TapeaUser> readUser(String id) async {
    final json = await readSingle(collection: "users", uid: id);
    return TapeaUser.fromJson(json);
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
