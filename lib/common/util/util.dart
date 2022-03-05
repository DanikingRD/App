import 'package:digital_card_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Util {
  Util._(); // Utility class not meant to be instantiated

  /// Creates a Scaffold and Container with a theme decoration
  /// and binds a column to place the widgets in order
  /// Made it scrollable to avoid overflowed pixels
  static Widget appScaffoldFor({required List<Widget> widgets}) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(gradient: appGradient),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: widgets
          ),
        ),
      ),
    );
  }

  static String checkLength(String email) {
    final int length = email.length;
    if (length > 70) {
      return email.substring(0, 70) + '...';
    } else {
      return email;
    }
  }
}

enum NavigationDir {
  next,
  previous,
}
