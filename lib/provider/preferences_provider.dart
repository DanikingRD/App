import 'package:digital_card_app/api/database.dart';
import 'package:digital_card_app/model/preferences.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/cupertino.dart';

class PreferencesProvider with ChangeNotifier {
  UserPreferences? _preferences;

  UserPreferences get getPreferences => _preferences!;

  Future<void> update(BuildContext context) async {
    final database = FirestoreAPI();
    _preferences = await database.readPreferences(
      FirebaseAuthAPI.getCurrentUser(context)!.uid,
    );
    notifyListeners();
  }
}
