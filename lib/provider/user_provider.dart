import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:firebase_cloud_functions/user/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  FirestoreUser? _user;

 FirestoreUser? get listener => _user;

  Future<void> init() async {
    _user = await FirebaseCloudServices.database.getSignedInUser();
    notifyListeners();
  }
}