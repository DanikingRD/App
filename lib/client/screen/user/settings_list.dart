import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double globalWidth = Get.width * 0.7;
    final double upperHeight = Get.height * 0.3;
    print('BUILDING');
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: upperHeight,
              width: globalWidth,
              color: homeColor,
            ),
            Expanded(
              child: Container(
                width: globalWidth,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
          )
        )
      ],
    );
  }
}
