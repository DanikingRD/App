import 'package:digital_card_app/screens/profile.dart';
import 'package:digital_card_app/screens/tapea_card.dart';
import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final List<Widget> homeScreenTabs = [
  TapeaCard(),
  Center(child: ElevatedButton(onPressed: () {
    FirebaseCloudServices.authService.signOut();
  }, child: Icon(Icons.person)),),
  ProfileScreen(uid: FirebaseCloudServices.authService.findUserID(),)
];