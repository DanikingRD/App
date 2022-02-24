import 'dart:async';
import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Get.offAllNamed(homePage.name),
    );
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
}
