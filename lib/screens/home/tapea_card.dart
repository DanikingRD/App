import 'package:digital_card_app/api/database.dart';
import 'package:digital_card_app/model/card.dart';
import 'package:digital_card_app/model/user.dart';
import 'package:digital_card_app/provider/user_provider.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TapeaCardScreen extends StatefulWidget {
  const TapeaCardScreen({Key? key}) : super(key: key);

  @override
  State<TapeaCardScreen> createState() => _TapeaCardScreenState();
}

class _TapeaCardScreenState extends State<TapeaCardScreen> {
  TapeaCard? _card;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final TapeaUser user = Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUser;
    if (user.devices > 0) {
      loadCard();
    }
  }

  void loadCard() async {
    setState(() {
      _loading = true;
    });
    final String id = FirebaseAuthAPI.getCurrentUser(context)!.uid;
    final json = await FirestoreAPI().readSingle(
      collection: "cards",
      uid: id,
    );
    _card = TapeaCard.fromJson(json);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _card == null
        ? const Center(
            child: Text("There are no cards created yet."),
          )
        : Scaffold(
            body: buildCard(context),
          );
  }

  Widget buildCard(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: ListView(
        children: [
          QrImage(
            data: _card!.name,
          ),
        ],
      ),
    );
  }
}
