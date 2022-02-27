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
    ValueChanged<String>? onChanged,
    FormFieldSetter<String>? onSaved,
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
          onChanged: onChanged,
          onSaved: onSaved,
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
    ValueChanged<String>? onChanged,
    FormFieldSetter<String>? onSaved,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: TextInputForm(
        label: label,
        inputAction: action,
        obscureText: obscureText,
        keyboardType: keybardType,
        cursorColor: cursorColor,
        autoFocusable: autoFocusable,
        icon: icon,
        controller: controller,
        onChanged: onChanged,
        onSaved: onSaved,
      ),
    );
  }
}

class UnderlinedTextInput extends TextFormField {
  UnderlinedTextInput({
    Key? key,
    required String label,
    Icon? icon,
    Color cursorColor = homeColor,
    TextInputAction? inputAction,
    bool obscureText = false,
    TextInputType? keyboardType,
    TextEditingController? controller,
    bool autoFocusable = false,
    FormFieldSetter<String>? onSaved,
    Color borderColor = homeColor,
    TextStyle? labelStyle,
    Icon? prefixIcon,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
  }) : super(
            decoration: InputDecoration(
              labelText: label,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(112, 112, 112, 1),
                  width: 2.0,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor,
                  width: 2.0,
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              floatingLabelStyle: labelStyle,
              prefixIcon: prefixIcon,
            ),
            autofocus: autoFocusable,
            controller: controller,
            textInputAction: inputAction,
            obscureText: obscureText,
            keyboardType: keyboardType,
            cursorColor: homeColor,
            validator: validator,
            onChanged: onChanged,
            onSaved: onSaved);
}
