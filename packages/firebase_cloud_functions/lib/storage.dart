import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {

 final FirebaseStorage _storage;

  FirebaseStorageService(this._storage);

  Future uploadImage({
    required String childName,
    required uid,
    required Uint8List file,
  }) async {
    final Reference ref = _storage.ref().child(childName).child(uid);
    final UploadTask task = ref.putData(file);
    final TaskSnapshot snapshot = await task;
    return await snapshot.ref.getDownloadURL();
  }
}
