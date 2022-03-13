import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/screens/router.dart';
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
            darkMode(),
            logout(),
            delete(),
          ],
        ),
      ],
    );
  }

  Widget darkMode() {
    return SimpleSettingsTile(
      title: "Theme",
      leading: const SettingsIcon(icon: Icons.palette, color: Colors.black),
      subtitle: '',
      onTap: () {
        Navigator.pushNamed(context, AppRouter.themeSettingsPage);
      },
    );
  }

  Widget logout() {
    return SimpleSettingsTile(
      title: "Logout",
      leading: const SettingsIcon(icon: Icons.logout, color: Colors.blue),
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
      leading: const SettingsIcon(icon: Icons.delete, color: logoRedColor),
    );
  }
}

class SettingsIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SettingsIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(
        icon,
      ),
    );
  }
}
