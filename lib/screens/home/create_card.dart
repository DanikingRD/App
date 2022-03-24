import 'dart:typed_data';

import 'package:digital_card_app/api/database.dart';
import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/model/card.dart';
import 'package:digital_card_app/model/user.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/util.dart';
import 'package:digital_card_app/widgets/text_input.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({Key? key}) : super(key: key);

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final List<TextInputManager> managers = [
    TextInputManager("Set  a card title (e.g Work or Personal)"),
    TextInputManager("Enter your first name"),
    TextInputManager("Enter your last name"),
    TextInputManager("Enter your job title"),
    TextInputManager("Enter your company name"),
  ];
  Uint8List? _selectedImage;
  Color color = logoRedColor;

  Future<void> onFinish() async {
    final String uid = FirebaseAuthAPI.getCurrentUser(context)!.uid;
    final TapeaCard card = TapeaCard(
      name: managers[0].controller.text,
      jobTitle: managers[3].controller.text,
      company: managers[4].controller.text,
      color: color.value,
      photo: null,
    );
    await FirestoreAPI().writeCard(
      id: uid,
      cardTitle: card.name,
      json: card.toJson(),
    );
  }

  bool isValid() {
    return managers[0].controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    for (int i = 0; i < managers.length; i++) {
      managers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              if (isValid()) {
                await onFinish();
              }
              Navigator.popAndPushNamed(
                context,
                AppRouter.cardPage,
              );
            },
            icon: const Icon(
              Icons.done,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: getAvatar(),
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: pickImage,
                  icon: const Icon(Icons.edit),
                ),
              )
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            itemCount: managers.length,
            itemBuilder: (BuildContext context, int index) {
              return CardTextInput(
                controller: managers[index].controller,
                floatingLabel: managers[index].title,
              );
            },
          ),
          Expanded(
            child: Container(),
            flex: 1,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Select card color",
              style: TextStyle(
                color: Util.getIconColorForTheme(context),
              ),
            ),
          ),
          Expanded(
            child: Container(),
            flex: 4,
          ),
        ],
      ),
    );
  }

  void pickImage() async {
    final Uint8List? data = await Util.pickImage(ImageSource.gallery);
    if (data != null) {
      setState(() => _selectedImage = data);
    }
  }

  ImageProvider<Object> getAvatar() {
    if (_selectedImage == null) {
      return const AssetImage("assets/image/default_avatar.jpg");
    } else {
      return MemoryImage(_selectedImage!);
    }
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

class TextInputManager {
  final String title;
  final TextEditingController controller;

  TextInputManager(this.title) : controller = TextEditingController();

  void dispose() {
    controller.dispose();
  }
}
