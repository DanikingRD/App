import 'package:digital_card_app/api/database.dart';
import 'package:digital_card_app/provider/theme_provider.dart';
import 'package:digital_card_app/util.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class ThemeSettingsScreen extends StatefulWidget {
  final ThemeMode localTheme;
  const ThemeSettingsScreen({
    Key? key,
    required this.localTheme,
  }) : super(key: key);

  @override
  State<ThemeSettingsScreen> createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  int _activeBox = 2;
  final options = [
    CheckBoxState(id: "light", index: 0),
    CheckBoxState(id: "dark", index: 1),
    CheckBoxState(id: "system", index: 2, value: true),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getInitialValue();
    });
  }

  void getInitialValue() {
    final ThemeProvider themeProvider = context.read<ThemeProvider>();
    // The theme is updated
    if (themeProvider.id == options[_activeBox].id) {
      return;
    }

    // We get all the boxes
    for (CheckBoxState box in options) {
      if (themeProvider.id == box.id) {
        updateInternalState(themeProvider, box.index);
      }
    }
  }

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
    final database = FirestoreAPI();
    updateInternalState(context.read<ThemeProvider>(), index);
    database.updateSingle(
      collection: "preferences",
      uid: FirebaseAuthAPI.getCurrentUser(context)!.uid,
      key: FirestoreJsonKeys.theme,
      value: options[_activeBox].id,
    );
  }

  void updateInternalState(ThemeProvider provider, int newActiveIndex) {
    setState(() {
      options[_activeBox].value = false;
      options[newActiveIndex].value = true;
      _activeBox = newActiveIndex;
      provider.toggle(_activeBox == 1 || _activeBox == 2);
    });
  }
}

class CheckBoxState {
  final String id;
  final int index;
  bool value = false;
  CheckBoxState({
    required this.id,
    required this.index,
    this.value = false,
  });
}
