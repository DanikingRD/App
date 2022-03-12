import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {

 final FirebaseStorage _storage;

  FirebaseStorageService(this._storage);

  Future<String?> uploadImage({
    required String childName,
    required uid,
    required Uint8List file,
  })  async {
    try {
      final Reference ref = _storage.ref().child(childName).child(uid);
      final UploadTask task = ref.putData(file);
      final snapshot = await task;
      return snapshot.ref.getDownloadURL();
    } on FirebaseException catch (exception) {
      print(file.toString());
      return null;
    }
  }
}
