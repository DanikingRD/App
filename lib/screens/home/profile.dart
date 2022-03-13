import 'package:digital_card_app/screens/router.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String uid;
  const Profile({Key? key, required this.uid}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    final json = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .get();

    account = json.data()!;
    setState(() {
      _loading = false;
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
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
                  await FirebaseAuthAPI.logout(context);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouter.loginPage,
                    (route) => false,
                  );
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
      backgroundImage: getAvatar(),
      radius: 64,
    );
  }

  ImageProvider<Object> getAvatar() {
    if (account["avatarURL"] == null) {
      return Image.asset("assets/image/default_avatar.jpg").image;
    }
    return NetworkImage(account["avatarURL"]);
  }
}
