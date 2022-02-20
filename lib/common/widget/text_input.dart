import 'package:digital_card_app/common/constants.dart';
import 'package:flutter/material.dart';

class TextInputForm extends TextFormField {
  
  TextInputForm({
    Key? key,
    required String label,
    Icon? icon,
    Color cursorColor = homeColor,
    TextInputAction? inputAction,
    bool obscureText = false,
    TextInputType? keyboardType,
    TextEditingController? controller,
    bool autoFocusable = false,
    FormFieldSetter<String>? onSaved
  }) : super(
          key: key,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: label,
            prefixIcon: icon,
          ),
          cursorColor: homeColor,
          
          textInputAction: inputAction,
          obscureText: obscureText,
          keyboardType: keyboardType,
          controller: controller,
          autofocus: autoFocusable,
          onSaved: onSaved
      );
  static Widget decoratedTextInput({
    required String label,
    Color backgroundColor = Colors.white,
    Color cursorColor = homeColor,
    TextInputAction? action,
    bool obscureText = false,
    TextInputType? keybardType,
    TextEditingController? controller,
    bool autoFocusable = false,
    Icon? icon,
    FormFieldSetter<String>? onSaved
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.only(left: 12),
      child: TextInputForm(
        label: label,
        inputAction: action,
        obscureText: obscureText,
        keyboardType: keybardType,
        cursorColor: cursorColor,
        autoFocusable: autoFocusable,
        icon: icon,
        controller: controller,
        onSaved: onSaved,
      ),
    );
  }
}
