part of firebase_cloud_functions;

/// Storage service class provides various firebase storage
/// related helper functions
class FirebaseStorageService {
  /// Get singleton instance of [FirebaseStorageService]
  static final FirebaseStorageService instance = FirebaseStorageService();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload given [file] to the provided [path]
  /// returns the downloadUrl for the uploaded file.
  Future<dynamic> uploadImage({
    required String childName,
    required uid,
    required Uint8List file,
  }) async {
    final Reference ref = _storage.ref().child(childName).child(uid);
    final UploadTask task = ref.putData(file);
    final snapshot = await task;
    return snapshot.ref.getDownloadURL();
  }
}
