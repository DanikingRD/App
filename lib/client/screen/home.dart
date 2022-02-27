import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:digital_card_app/common/model/user.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel.dummy();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((document) => {
              loggedInUser = UserModel.fromMap(document.data()),
              setState(() {}),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.toNamed(settingsListPage.name);
          },
          splashRadius: appSplashRadius,
          icon: const Icon(Icons.list),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: appSplashRadius,
            onPressed: () {},
            icon: const Icon(
              Icons.add,
            ),
          ),
          IconButton(
            splashRadius: appSplashRadius,
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
            ),
          )
        ],
        title: const Text(
          'Work',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Image.asset('assets/image/qr_code.png'),
            height: Get.height / 2,
          ),
          const Divider(thickness: 3.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${loggedInUser.firstName} ${loggedInUser.lastName}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildIconTree(context),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildIconTree(BuildContext ctx) {
    return Column(
      children: [
        appendIconStack(
          label: Util.checkLength(loggedInUser.email),
          subLabel: 'email',
          icon: Icons.email,
        ),
        if (loggedInUser.phoneNumber != null) ...{
          const SizedBox(height: 12),
          appendIconStack(
            label: loggedInUser.phoneNumber!,
            subLabel: 'mobile',
            icon: Icons.phone,
          ),
        }
      ],
    );
  }

  Widget appendIconStack({
    required final String label,
    required final String subLabel,
    required final IconData icon,
    bool addSpace = false,
  }) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.circle,
              color: homeColor,
              size: 50,
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
          ],
        ),
        SizedBox(
          width: Get.width * 0.70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subLabel,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
