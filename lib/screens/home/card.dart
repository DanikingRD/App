import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/model/card.dart';
import 'package:digital_card_app/model/user.dart';
import 'package:digital_card_app/provider/card_provider.dart';
import 'package:digital_card_app/provider/user_provider.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TapeaCardScreen extends StatefulWidget {
  const TapeaCardScreen({Key? key}) : super(key: key);

  @override
  State<TapeaCardScreen> createState() => _TapeaCardScreenState();
}

class _TapeaCardScreenState extends State<TapeaCardScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final card = Provider.of<CardProvider>(context).getCard;
    return card == null
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
    final TapeaUser user = Provider.of<UserProvider>(context).getUser;
    final TapeaCard defaultCard = Provider.of<CardProvider>(context).getCard;
    final String fullName = user.firstName + user.lastName;
    final String job = defaultCard.jobTitle;
    final String company = defaultCard.company;
    final String email = user.email;
    final card = Provider.of<CardProvider>(context).getCard;
    final qr = QrImage(data: card.firstName);

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Edit card
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRouter.cardEditorPage, arguments: false),
            icon: const Icon(Icons.edit_outlined),
          ),
          // Create card
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.cardEditorPage, arguments:  true);
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
        ],
        title: SafeArea(
          child: Image.asset(
            "assets/image/tapea.png",
            height: 48,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: qr,
            ),
          ),
          const SizedBox(height: 30),
          const Divider(
            thickness: 3.0,
          ),
          ListTile(
            title: Text(
              fullName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            subtitle: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: job + "\n",
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextSpan(
                  text: company,
                  style: Theme.of(context).textTheme.headline6,
                )
              ]),
            ),
            isThreeLine: true,
          ),
          const SizedBox(height: 20),
          buildListTile(
            icon: Icons.email,
            title: email,
            subtitle: "email",
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 120,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRouter.shareCardPage,
                    arguments: qr,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      logoRedColor,
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.share),
                      Text(
                        "\t\tSHARE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildListTile(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return ListTile(
        leading: ClipOval(
          child: Container(
            height: 40,
            width: 40,
            color: logoRedColor,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle));
  }
}
