import 'dart:developer';

import 'package:digital_card_app/screens/welcome/introduction.dart';
import 'package:digital_card_app/screens/welcome/options.dart';
import 'package:digital_card_app/screens/welcome/share.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreenLayout extends StatefulWidget {
  const WelcomeScreenLayout({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenLayout> createState() => _WelcomeScreenLayoutState();
}

class _WelcomeScreenLayoutState extends State<WelcomeScreenLayout> {
  final PageController _controller = PageController();
  final _log = Logger((WelcomeScreenLayout).toString());
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getTextColor(bool isDarkMode) {
    return isDarkMode ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    _log.fine("test");
    const Duration duration = Duration(milliseconds: 250);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          children: const [
            IntroductionPage(),
            SharePage(),
            OptionsPage(),
          ],
        ),
      ),
      bottomSheet: Container(
        color: getButtomSheetColor(isDarkMode),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => _controller.jumpToPage(1),
              child: Text(
                "SKIP",
                style: TextStyle(
                  color: getTextColor(isDarkMode),
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: WormEffect(
                spacing: 16,
                activeDotColor: getTextColor(isDarkMode),
                dotColor: Colors.grey,
              ),
              onDotClicked: (index) => _controller.animateToPage(
                index,
                duration: duration,
                curve: Curves.easeInOut,
              ),
            ),
            TextButton(
              onPressed: () => _controller.nextPage(
                duration: duration,
                curve: Curves.easeInOut,
              ),
              child: Text(
                "NEXT",
                style: TextStyle(
                  color: getTextColor(isDarkMode),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getButtomSheetColor(bool isDarkMode) {
    return isDarkMode ? Colors.white : const Color.fromARGB(255, 31, 47, 61);
  }
}
