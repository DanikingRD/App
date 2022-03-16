import 'package:digital_card_app/model/preferences.dart';
import 'package:digital_card_app/model/user.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/cupertino.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Contacts"),
    );
  }
}
