import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Util {
  Util._(); // Utility class not meant to be instantiated

  static String checkLength(String email) {
    final int length = email.length;
    if (length > 70) {
      return email.substring(0, 70) + '...';
    } else {
      return email;
    }
  }

  static void popUpToast({
    required String msg,
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = Colors.black,
    Color foregroundColor = Colors.white,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: foregroundColor,

    );
  }
}

enum NavigationDir {
  next,
  previous,
}
