import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  static const bottomPages = 4;
  HomeProvider();
  int page = 0;

  final FirebaseFirestore _database = FirebaseFirestore.instance;

  void loadTheme() {}

  Future<void> updatePreference({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    await _database.collection("preferences").doc(id).update({
      key: value,
    });
  }

  void nextPage(int activePage) {
    if (activePage < bottomPages) {
      page++;
      notifyListeners();
    }
  }
}
