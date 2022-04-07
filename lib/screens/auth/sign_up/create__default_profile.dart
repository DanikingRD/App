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
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';

class CreateDefaultProfile extends StatefulWidget {
  final Map<String, String> account;
  const CreateDefaultProfile({Key? key, required this.account}) : super(key: key);

  @override
  State<CreateDefaultProfile> createState() => _CreateDefaultProfileState();
}

class _CreateDefaultProfileState extends State<CreateDefaultProfile> {
  final TextEditingController _cardTitle = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _jobTitle = TextEditingController();
  final TextEditingController _company = TextEditingController();
  final Color color = logoRedColor;
  final GlobalKey<FormState> form = GlobalKey();
  static final Logger log = Logger("$CreateDefaultProfile");

  Uint8List? _selectedImage;
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _cardTitle.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _jobTitle.dispose();
    _company.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: form,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Create your first card",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 48),
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
                const SizedBox(
                  height: 48,
                ),
                TextFormInput(
                  controller: _cardTitle,
                  hintText: "Card Title",
                  textInputType: TextInputType.name,
                  validator: validate,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormInput(
                  controller: _firstName,
                  hintText: "First Name",
                  textInputType: TextInputType.name,
                  validator: validate,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormInput(
                  controller: _lastName,
                  hintText: "Last Name",
                  textInputType: TextInputType.name,
                  validator: validate,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormInput(
                  controller: _jobTitle,
                  hintText: "Job Title",
                  textInputType: TextInputType.name,
                  validator: validate,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormInput(
                  controller: _company,
                  hintText: "Company",
                  textInputType: TextInputType.name,
                  validator: validate,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () {
                    if (form.currentState!.validate()) {
                      form.currentState!.save();
                      signUp();
                    }
                  },
                  child: Container(
                    child: _loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text('Sign Up'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: logoRedColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    log.info("Registering user");
    setState(() {
      _loading = true;
    });
    final database = FirestoreAPI();
    final String email = widget.account["Email"]!;
    final String password = widget.account["Password"]!;
    await FirebaseAuthAPI.register(
      context: context,
      email: email,
      password: password,
      onError: (String message) {
        log.severe("Failed to register user, $message");
        Util.showSnackBar(
          context: context,
          content: message,
        );
      },
      onSuccess: (User? user) async {
        final String uid = user!.uid;
        String? imageURL;
        if (_selectedImage != null) {
          // We selected a profile image
          imageURL = await FirebaseStorageService.instance.uploadImage(
            childName: "avatars",
            uid: uid,
            file: _selectedImage!,
          );
        }
        final TapeaUser newUser = TapeaUser(
          firstName: _firstName.text,
          lastName: _lastName.text,
          uid: uid,
          username: widget.account["Username"]!,
          email: email,
          avatarURL: imageURL,
          profiles: 1,
          defaultProfile: _cardTitle.text
        );  
        database.writeSingle(
          collection: "users",
          path: newUser.uid,
          json: newUser.toJson(),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.homePage,
          (_) => false,
        );
      },
    );
    await createCard(database);
    setState(() {
      _loading = false;
    });
    log.fine("User registered");
  }

  Future<TapeaCard> createCard(FirestoreAPI api) async {
    final String id = FirebaseAuthAPI.getCurrentUser(context)!.uid;
    final TapeaCard card = TapeaCard(
      title: _cardTitle.text,
      firstName: _firstName.text,
      lastName: _lastName.text,
      jobTitle: _jobTitle.text,
      company: _company.text,
      color: color.value,
    );
    await api.writeCard(
      id: id,
      cardTitle: _cardTitle.text,
      json: card.toJson(),
    );
    return card;
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

  String? validate(final String? input) {
    if (input!.isEmpty) {
      return "The field is required";
    } else {
      return null;
    }
  }
}
