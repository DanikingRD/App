import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  //final AuthService _service;

  static const String identifier = '/welcome';

  const WelcomeScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.height,
          decoration: const BoxDecoration(gradient: appGradient),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/image/logo.png'),
              const SizedBox(height: 15),
              const Text('Tapea',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 250,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: const Text('GET STARTED',
                      style: TextStyle(color: homeColor, fontSize: 20)),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Get.toNamed(authPage.name);
                },
                child: const Text('LOG IN WITH EXISTING ACCOUNT',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
