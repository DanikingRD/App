import 'package:digital_card_app/api/database.dart';
import 'package:digital_card_app/model/user.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  TapeaUser? _user;

  TapeaUser get getUser => _user!;

  Future<void> update(BuildContext context) async {
    final database = FirestoreAPI();
    _user = await database.readUser(
      FirebaseAuthAPI.getCurrentUser(context)!.uid,
    );
    notifyListeners();
  }
}
