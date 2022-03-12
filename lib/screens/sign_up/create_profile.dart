import 'dart:typed_data';

import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/screens/home.dart';
import 'package:digital_card_app/util.dart';
import 'package:digital_card_app/widgets/text_input.dart';
import 'package:firebase_cloud_functions/auth.dart';
import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:async';
class CreateProfile extends StatefulWidget {
  final Map<String, String> account;
  const CreateProfile({Key? key, required this.account}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
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
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormInput(
              controller: _lastName,
              hintText: "Last Name",
              textInputType: TextInputType.name,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: signUp,
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
                  color: homeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    setState(() {
      _loading = true;
    });
    final String output = await FirebaseCloudServices.authService.signUp(
      username: widget.account["Username"]!,
      email: widget.account["Email"]!,
      password: widget.account["Password"]!,
      image: _selectedImage,
    ).onError((error, stackTrace) {
      setState(() {
        _loading = false;
      });
    });
    Util.showSnackBar(context: context, content: output, seconds: 2);
    setState(() {
      _loading = false;
    });
    if (output == FirebaseAuthMessage.signedUp) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  void pickImage() async {
    final Uint8List? data = await Util.pickImage(ImageSource.camera);
    if (data!= null) {
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
}
