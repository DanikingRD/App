import 'package:digital_card_app/provider/home.dart';
import 'package:digital_card_app/provider/theme.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  int _activeBox = 2;
  final options = [
    CheckBoxState(id: "light"),
    CheckBoxState(id: "dark"),
    CheckBoxState(id: "system", value: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Set theme"),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
              title: const Text("Light"),
              value: options[0].value,
              onChanged: (value) {
                selectBox(0);
              }),
          CheckboxListTile(
            title: const Text("Dark"),
            value: options[1].value,
            onChanged: (value) {
              selectBox(1);
            },
          ),
          CheckboxListTile(
            title: const Text("System default"),
            value: options[2].value,
            onChanged: (value) {
              selectBox(2);
            },
          ),
        ],
      ),
    );
  }

  void selectBox(int index) async {
    // Fast return to avoid unnecessary rebuilds
    // if we are not switching the mode.
    if (_activeBox == index) {
      return;
    }
    final activeTheme = Provider.of<ThemeProvider>(context, listen: false);
    final manager = Provider.of<HomeProvider>(context, listen: false);
    setState(() {
      options[_activeBox].value = false;
      options[index].value = true;
      _activeBox = index;
      activeTheme.toggle(_activeBox == 1 || _activeBox == 2);
    });
    // Update firestore
    await manager.updateJsonEntry(
      collection: "preferences",
      key: manager.preferences["theme"],
      value: options[_activeBox].id,
    );
  }
}

class CheckBoxState {
  final String id;
  bool value = false;
  CheckBoxState({
    required this.id,
    this.value = false,
  });
}
