part of firebase_cloud_functions;

// Allows to modify a collection of documents from firebase
class FirestoreCollection {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _collection;

  FirestoreCollection(String collection)
      : _collection = FirebaseFirestore.instance.collection(collection);

  Future<void> setJson({
    required String path,
    required Map<String, dynamic> json,
  }) async {
    await _collection.doc(path).set(json);
  }

  CollectionReference get collection => _collection;
  FirebaseFirestore get database => _firestore;
}
