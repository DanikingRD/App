import 'dart:typed_data';

import 'package:digital_card_app/api/database.dart';
import 'package:digital_card_app/model/card.dart';
import 'package:digital_card_app/provider/card_provider.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/screens/home/card/card_constants.dart';
import 'package:digital_card_app/util.dart';
import 'package:digital_card_app/widgets/text_input.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

class CardEditor extends StatefulWidget {
  bool createNewCard;

  CardEditor({
    required this.createNewCard,
    Key? key,
  }) : super(key: key);

  @override
  State<CardEditor> createState() => _CardEditorState();
}

class _CardEditorState extends State<CardEditor> {
  final List<CardEditorTextManager> managers = [
    CardEditorTextManager("Set  a card title (e.g Work or Personal)"),
    CardEditorTextManager("Enter your first name"),
    CardEditorTextManager("Enter your last name"),
    CardEditorTextManager("Enter your job title"),
    CardEditorTextManager("Enter your company name"),
  ];

  Uint8List? _selectedImage;
  Color color = logoRedColor;

  @override
  void dispose() {
    for (int i = 0; i < managers.length; i++) {
      managers[i].dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    if (!widget.createNewCard) {
      updateControllers();
    }
    super.initState();
  }

  void updateControllers() {
    final TapeaCard card =
        Provider.of<CardProvider>(context, listen: false).getCard;
    managers[0].controller.text = card.title;
    managers[1].controller.text = card.firstName;
    managers[2].controller.text = card.lastName;
    managers[3].controller.text = card.jobTitle;
    managers[4].controller.text = card.company;
  }

  bool isValid() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final titleManager = managers[0];
    final firstNameManager = managers[1];
    final lastNameManager = managers[2];
    final jobManager = managers[3];
    final companyManager = managers[4];
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        children: [
          Center(
            child: Stack(
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
          ),
          CardTextInput(
            controller: titleManager.controller,
            floatingLabel: titleManager.title,
          ),
          CardTextInput(
            controller: firstNameManager.controller,
            floatingLabel: firstNameManager.title,
          ),
          CardTextInput(
            controller: lastNameManager.controller,
            floatingLabel: lastNameManager.title,
          ),
          CardTextInput(
            controller: jobManager.controller,
            floatingLabel: jobManager.title,
          ),
          CardTextInput(
            controller: companyManager.controller,
            floatingLabel: companyManager.title,
          ),
          SizedBox(
            width: 80,
            height: 40,
            child: TextButton(
              onPressed: () async {
                if (isValid()) {
                  updateCard(context);
                }
                Navigator.pop(context);
              },
              child: const Text(
                "DONE",
                style: TextStyle(color: logoRedColor, fontSize: 14),
              ),
            ),
          ),
        ],
        // child: Column(
        //   children: [

        //     // Expanded(
        //     //   child: Container(),
        //     //   flex: 1,
        //     // ),

        //     // Expanded(
        //     //   child: Container(),
        //     //   flex: 4,
        //     // ),
        //   ],
        // ),
      ),
    );
  }

  ImageProvider<Object> getAvatar() {
    if (_selectedImage == null) {
      return const AssetImage("assets/image/default_avatar.jpg");
    } else {
      return MemoryImage(_selectedImage!);
    }
  }

  void pickImage() async {
    final Uint8List? data = await Util.pickImage(ImageSource.gallery);
    if (data != null) {
      setState(() => _selectedImage = data);
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

  Future<void> updateCard(BuildContext context) async {
    final String uid = FirebaseAuthAPI.getCurrentUser(context)!.uid;
    final TapeaCard card = TapeaCard(
      title: managers[0].controller.text,
      firstName: managers[1].controller.text,
      lastName: managers[2].controller.text,
      jobTitle: managers[3].controller.text,
      company: managers[4].controller.text,
      photo: null,
    );
    await FirestoreAPI().writeCard(
      id: uid,
      cardTitle: card.title,
      json: card.toJson(),
    );
    Provider.of<CardProvider>(
      context,
      listen: false,
    ).update(card.title, context);
  }
}
