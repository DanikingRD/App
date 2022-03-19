import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({Key? key}) : super(key: key);

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _name = TextEditingController();

  Color color = logoRedColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Build your card"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CardTextInput(
              controller: _title,
              floatingLabel: "Set a card title (e.g Work or Personal)",
            ),
            CardTextInput(
              controller: _name,
              floatingLabel: "Enter your name",
            ),
            IconButton(
              onPressed: pickColor,
              icon: const Icon(Icons.palette_sharp),
            ),
          ],
        ),
      ),
    );
  }

  void pickColor() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Pick your color"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildColorPicker(),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "DONE",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildColorPicker() {
    return ColorPicker(
      pickerColor: color,
      enableAlpha: false,
      labelTypes: const [],
      onColorChanged: (color) => setState(() => this.color = color),
      paletteType: PaletteType.hueWheel,
    );
  }
}
