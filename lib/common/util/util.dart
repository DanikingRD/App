import 'dart:math';

import 'package:flutter/material.dart';

class AppUtil {
  // Utility class not meant to be instantiated
  AppUtil._();

  static Widget navigationButton(BuildContext ctx,IconData icon, Function() clickHandler, {
    double? elevation, Color? splashColor,
  }) {
    return FloatingActionButton(
      elevation: elevation,
      splashColor: splashColor,
      child: Icon(icon),
      onPressed: clickHandler,
      backgroundColor: Theme.of(ctx).primaryColor,
    );
  }

  static Widget textInput({
    TextEditingController? controller,
    String? text,
    Icon? icon,
    bool? hiddenText,
    Color? color,
    TextInputAction? action,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: color),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: text, prefixIcon: icon),
        obscureText: hiddenText ?? false,
        textInputAction: action,
      ),
    );
  }

  static TextFormField textInputWithBorder({
    required BuildContext ctx,
    required String label,
    IconData? icon,
    TextEditingController? controller,
    required TextInputAction action,
    bool? hiddenText,
    TextInputType? keyboardType,
  }) {
    final primaryColor = Theme.of(ctx).primaryColor;
    final UnderlineInputBorder focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2.0),
    );
    const UnderlineInputBorder enabledBorder = UnderlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 112, 112, 112), width: 2.0),
    );
    final TextStyle floatingLabelStyle = TextStyle(color: primaryColor);
    final InputDecoration decoration = InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        floatingLabelStyle: floatingLabelStyle,
        prefixIcon: icon == null ? null : Icon(icon),
        border: InputBorder.none);

    return TextFormField(
      autofocus: false,
      controller: controller,
      textInputAction: action,
      decoration: decoration,
      obscureText: hiddenText ?? false,
      keyboardType: keyboardType,
    );
  }
}
