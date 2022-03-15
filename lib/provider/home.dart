import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  static const bottomPages = 4;
  final String uid;
  HomeProvider(this.uid);
  int page = 0;
  late final Map<String, dynamic> preferences;

  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<void> init() async {
    final json = await _database.collection("preferences").doc(uid).get();
    preferences = json.data()!;
  }

  void nextPage(int activePage) {
    if (activePage < bottomPages) {
      page++;
      notifyListeners();
    }
  }

  void updatePreferences() {}

  Future<void> updateJsonEntry({
    required String collection,
    required String key,
    dynamic value,
  }) async {
    await _database.collection(collection).doc(uid).update({
      key: value,
    });
  }
}
