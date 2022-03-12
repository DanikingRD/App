import 'package:flutter/material.dart';

class TextFormInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final bool password;
  final FormFieldValidator<String>? validator;
  const TextFormInput({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    this.password = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: password,
      validator: validator,
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
