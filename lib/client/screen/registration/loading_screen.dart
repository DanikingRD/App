import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:digital_card_app/common/model/user.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  static final AuthService authServiceProvider = AuthService();

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
  // Timer(const Duration(seconds: 1), attemptToRegister);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: const [
            Text(
              'Hang tight, we\'re signing you in!',
              style: TextStyle(fontSize: 24),
            ),
            Expanded(
              // This expands the row element vertically because it's inside a column
              child: SpinKitRing(
                color: homeColor,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }

  // void attemptToRegister() async {
  //   await LoadingScreen.authServiceProvider
  //       .createUser(
  //         email: Get.arguments['email'],
  //         password: Get.arguments['password'],
  //       )
  //       .then(
  //         (value) => {
  //           createUserModel(value!),
  //         },
  //       );
  // }

  // void createUserModel(UserCredential credential) async {
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final User? user = credential.user;
  //   assert(user != null);
  //   assert(user!.email != null);
  //   final UserModel model = UserModel(
  //       uid: user!.uid,
  //       email: user.email!,
  //       firstName: Get.arguments['firstName'],
  //       lastName: Get.arguments['lastName'],
  //       phoneNumber: Get.arguments['phoneNumber']);
  //   await firestore.collection('users').doc(user.uid).set(model.toMap());
  //   Get.offAllNamed(homePage.name, arguments: user);
  //   RegistrationFormTemplateState.form.clear();
  }

