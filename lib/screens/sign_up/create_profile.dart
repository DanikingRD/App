import 'dart:typed_data';

import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/model/preferences.dart';
import 'package:digital_card_app/model/user.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/util.dart';
import 'package:digital_card_app/widgets/text_input.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  final Map<String, String> account;

  const CreateProfile({Key? key, required this.account}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();
  Uint8List? _selectedImage;
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Create a Profile",
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
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
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
    );
  }

  void signUp() async {
    setState(() {
      _loading = true;
    });
    final String email = widget.account["Email"]!;
    final String password = widget.account["Password"]!;
    await FirebaseAuthAPI.register(
      context: context,
      email: email,
      password: password,
      onError: (String message) {
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
          uid: uid,
          username: widget.account["Username"]!,
          email: email,
          avatarURL: imageURL,
        );
        FirestoreCollection("users").setJson(
          path: newUser.uid,
          json: newUser.toJson(),
        );
        final UserPreferences settings = UserPreferences(
          uid: uid,
          theme: "system",
        );
        FirestoreCollection("preferences").setJson(
          path: uid,
          json: settings.toJson(),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.homePage,
          (_) => false,
        );
      },
    );
    setState(() {
      _loading = false;
    });
  }

  void pickImage() async {
    final Uint8List? data = await Util.pickImage(ImageSource.camera);
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
