import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/util.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        SettingsGroup(
          title: "GENERAL",
          children: [
            logout(),
            delete(),
          ],
        ),
      ],
    );
  }

  Icon getIcon(IconData data) {
    return Icon(data, color: Colors.black);
  }

  Widget logout() {
    return SimpleSettingsTile(
      title: "Logout",
      leading: getIcon(Icons.logout),
      subtitle: '',
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text("Log out of Tapea?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouter.loginPage,
                        (_) => false,
                      );
                      await FirebaseAuthAPI.logout(context);
                    },
                    child: const Text("Log out"),
                  ),
                ],
              );
            });
      },
    );
  }

  Widget delete() {
    return SimpleSettingsTile(
      title: "Delete Account",
      subtitle: '',
      leading: getIcon(Icons.delete),
    );
  }
}
