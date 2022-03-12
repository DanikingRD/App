import 'package:digital_card_app/util.dart';
import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> account = {};
  late ImageProvider avatar;

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
      account = await FirebaseCloudServices.database.findAccountData(widget.uid);
      avatar = await getProfileAvatar();
      setState(() {});
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
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(account["username"]),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: avatar,
                            backgroundColor: Colors.grey,
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    renderStat(0, "Cards"),
                                    renderStat(0, "Contacts")
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Future<ImageProvider<Object>> getProfileAvatar() async {
    if (account["avatarURL"] == null) {
      return Image.asset("assets/image/default_avatar.jpg").image;
    }
    return NetworkImage(account["avatarURL"]);
  }

  Widget renderStat(int number, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
