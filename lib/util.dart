import 'dart:typed_data';

import 'package:digital_card_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// Firestore keys
class FirestoreJsonKeys {
  static const String theme = "theme";
}

class TapeaThemes {
  static final darkTheme = ThemeData(
    primaryColor: logoRedColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0.0,
      shadowColor: Colors.white,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Color.fromARGB(255, 19, 19, 19),
    ),
    colorScheme: const ColorScheme.dark().copyWith(primary: Colors.grey),
  );
  static final lightTheme = ThemeData(
    primaryColor: logoRedColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[300]),
    colorScheme: const ColorScheme.light().copyWith(primary: Colors.grey),
  );
}

class Util {
  Util._(); // Utility class not meant to be instantiated or extended

// For picking up images
  static Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    return null;
  }

  static showSnackBar({
    required final BuildContext context,
    required final String content,
    final int seconds = 4,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(seconds: seconds),
      ),
    );
  }

  /// Creates a Scaffold and Container with a theme decoration
  /// and binds a column to place the widgets in order
  /// Made it scrollable to avoid overflowed pixels
  static Widget setScaffold({required List<Widget> widgets}) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(gradient: appGradient),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(children: widgets),
        ),
      ),
    );
  }

  /// Basic String validation for simple forms
  static String? validateTextFieldString(String? text) {
    if (text == null || text.isEmpty) {
      return 'The field is empty';
    } else if (text.contains(RegExp(r'[0-9]'))) {
      return 'Enter a valid name';
    } else if (!text.contains(RegExp(r'[A-Z]', caseSensitive: false))) {
      return 'Enter a valid name';
    } else {
      return null;
    }
  }
}
