import 'package:digital_card_app/pages/pages.dart';
import 'package:flutter/material.dart';

enum NavigationEntry {
  account,
}

class NavigationDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Drawer(
      backgroundColor: color,
      child: ListView(
        children: [
          const SizedBox(height: 60),
          newEntry(
            text: 'Manage my account',
            icon: Icons.email,
            clickHandler: () => selectEntry(
              context,
              NavigationEntry.account,
            ),
          ),
        ],
      ),
    );
  }

  void selectEntry(final BuildContext context, final NavigationEntry entry) {
    switch (entry) {
      case NavigationEntry.account:
        Navigator.pushNamed(context, manageAccountPage);
        break;
    }
  }

  Widget newEntry(
      {required String text,
      required IconData icon,
      VoidCallback? clickHandler}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: clickHandler,
    );
  }
}
