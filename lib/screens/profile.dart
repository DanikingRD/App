import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/util.dart';
import 'package:firebase_cloud_functions/auth.dart';
import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Map<String, dynamic> account;
  late final ImageProvider<Object> avatar;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      _loading = true;
    });
    try {
      account =
          await FirebaseCloudServices.database.findAccountData(widget.uid);
      avatar = await getAvatar();
    } on Exception catch (e) {
      Util.showSnackBar(context: context, content: e.toString());
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : profile(context);
  }

  Widget profile(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Stack(
              children: [
                profileAvatar(),
                Positioned(
                  bottom: -12,
                  right: -8,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            buildCredentials(
              username: account["username"],
              email: account["email"],
            ),
            TextButton(
                onPressed: () async {
                  await FirebaseCloudServices.authService.signOut();
                  Navigator.pushReplacementNamed(context, AppRouter.loginPage);
                },
                child: const Text("DISCONNECT"))
          ],
        ),
      ),
    );
  }

  Widget buildCredentials({required String username, required String email}) {
    return Column(
      children: [
        Text(
          username,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          email,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget profileAvatar() {
    return CircleAvatar(
      backgroundImage: avatar,
      radius: 64,
    );
  }

  Future<ImageProvider<Object>> getAvatar() async {
    if (account["avatarURL"] == null) {
      return Image.asset("assets/image/default_avatar.jpg").image;
    }
    return NetworkImage(account["avatarURL"]);
  }
}
