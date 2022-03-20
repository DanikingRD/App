import 'package:digital_card_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Share your business card with anyone, anywhere",
            style: TextStyle(
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          LottieBuilder.asset("assets/model/animation/social_media_icons.json"),
          Text(
            "Share your virtual business card using a QR code or send it through email, text, social media, and more. Anyone can receive your digital card, even if they don't have the app.",
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
