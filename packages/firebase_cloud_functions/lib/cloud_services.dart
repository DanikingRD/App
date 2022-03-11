import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_functions/auth.dart';
import 'package:firebase_cloud_functions/database.dart';
import 'package:firebase_cloud_functions/storage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseCloudServices {

  static final FirebaseAuthService authService = FirebaseAuthService(FirebaseAuth.instance);
  static final FirebaseDatabase database = FirebaseDatabase(FirebaseFirestore.instance);
  static final FirebaseStorageService storageService = FirebaseStorageService(FirebaseStorage.instance);
}