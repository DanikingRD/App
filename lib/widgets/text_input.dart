import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final bool password;

  const TextInput({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    this.password = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context),);
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: password,
      decoration: InputDecoration(
        hintText: hintText,
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        filled: true,
        contentPadding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
