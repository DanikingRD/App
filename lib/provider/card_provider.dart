import 'package:digital_card_app/api/database.dart';
import 'package:digital_card_app/model/card.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/cupertino.dart';

class CardProvider with ChangeNotifier {

  TapeaCard? _card;

  TapeaCard get getCard => _card!;

    Future<void> update(String title, BuildContext context) async {
    final database = FirestoreAPI();
    final String uid = FirebaseAuthAPI.getCurrentUser(context)!.uid;
    _card = await database.readCard(uid: uid, cardTitle: title);
    notifyListeners();
  }

}