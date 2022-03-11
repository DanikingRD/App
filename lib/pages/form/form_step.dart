import 'package:flutter/material.dart';

class StepFieldData {
  final String label;
  final String? fillHint;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller = TextEditingController();
  // final String? topLabelText;
  // final String? bottomLabelText;
  // final String? topFillHint;
  // final String? bottomFillHint;
  // final FormFieldValidator<String>? topValidator;
  // final FormFieldValidator<String>? bottomValidator;
  // final String? Function(String? bottom, String? top)? allMatch;

  StepFieldData({
    required this.label,
    this.fillHint,
    this.validator,
  });
}

class FormStepBody extends StatefulWidget {
  final String header;
  final GlobalKey<FormState> formKey;
  final List<StepFieldData> fields;
  static const int _textFieldLimit = 3;
  const FormStepBody({
    required this.header,
    required this.formKey,
    required this.fields,
  }) : super();

  @override
  State<FormStepBody> createState() => FormStepBodyState();

  static InputDecoration getDecoration({
    required primaryColor,
    required labelText,
  }) {
    return InputDecoration(
      labelText: labelText,
      alignLabelWithHint: true,
      floatingLabelStyle: TextStyle(color: primaryColor),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(112, 112, 112, 1),
          width: 2.0,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
          width: 2.0,
        ),
      ),
    );
  }
}

class FormStepBodyState extends State<FormStepBody> {
  final TextEditingController _topController = TextEditingController();
  final TextEditingController _bottomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const margin = SizedBox(height: 15);
    final int length = widget.fields.length;
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.header,
            style: const TextStyle(fontSize: 24),
          ),
          TextFormField(
            decoration: FormStepBody.getDecoration(
              primaryColor: primaryColor,
              labelText: widget.fields[0].label,
            ),
            controller: _topController,
            cursorColor: primaryColor,
            validator: (text) => validate(text, true),
            autofillHints: widget.fields[0].fillHint == null
                ? null
                : [
                    widget.fields[0].fillHint!,
                  ],
          ),
          margin,
          if (length > 0) ...{
            TextFormField(
              decoration: FormStepBody.getDecoration(
                primaryColor: primaryColor,
                labelText: widget.fields[1].label,
              ),
              controller: _bottomController,
              cursorColor: primaryColor,
              validator: (text) => validate(text, false),
              autofillHints: widget.fields[1].fillHint == null
                  ? null
                  : [
                      widget.fields[1].fillHint!,
                    ],
            ),
            margin,
          },
          if (length > 1) ... {

          }
        ],
      ),
    );
  }

  String? validate(String? text, final bool top) {
    final str = text!;
    if (str.isEmpty) {
      return 'The field is required';
    }
    // if (widget.allMatch != null) {
    //   return widget.allMatch!(_topController.text, _bottomController.text);
    // }
    // final topHandler = widget.topValidator;
    // final bottomHandler = widget.bottomValidator;
    // if (topHandler == null && bottomHandler == null) {
    //   return null;
    // }
    // if (top && topHandler != null) {
    //   return topHandler(text);
    // }
    // if (!top && bottomHandler != null) {
    //   return bottomHandler(text);
    // }
    return null;
  }
}
