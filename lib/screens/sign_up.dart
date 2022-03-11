import 'dart:typed_data';

import 'package:firebase_cloud_functions/auth.dart';
import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/screens/login.dart';
import 'package:digital_card_app/util.dart';
import 'package:digital_card_app/widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  Uint8List? _image;
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _bio.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Image.asset(
                'assets/image/tapea.png',
                height: 64,
              ),
              const SizedBox(height: 64),
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
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 64),
              TextInput(
                controller: _username,
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              TextInput(
                hintText: 'Enter your email',
                controller: _email,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              TextInput(
                controller: _password,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                password: true,
              ),
              const SizedBox(height: 24),
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
              const SizedBox(height: 12),
              Flexible(
                child: Container(),
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Already have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: openLoginScreen,
                    child: Container(
                      child: const Text(
                        "Log in.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider<Object> getAvatar() {
    if (_image == null) {
      return const AssetImage("assets/image/default_avatar.jpg");
    } else {
      return MemoryImage(_image!);
    }
  }

  void signUp() async {
    setState(() {
      _loading = true;
    });
    final String output = await FirebaseCloudServices.authService.signUp(
      email: _email.text,
      password: _password.text,
      username: _username.text,
      file: _image,
    );
    setState(() {
      _loading = false;
    });
    if (output == FirebaseAuthMessage.signedUp) {
      openLoginScreen();
    }
  }

  void openLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void pickImage() async {
    final Uint8List? img = await Util.pickImage(ImageSource.camera);
    if (img != null) {
      setState(() => _image = img);
    }
  }
}
