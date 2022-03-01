import 'package:digital_card_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget widget = buildContainer();
    return Draggable(
      child: widget,
      feedback: Text(''),
    );
  }

  Widget buildContainer() {
    final double draggableWidth = Get.width * 0.7;
    final double upperHeight = Get.height * 0.3;
    final double remainingHeight = Get.height - upperHeight;
    final double remainingWidth = Get.width - draggableWidth;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: upperHeight,
              width: draggableWidth,
              color: homeColor,
            ),
            Container(
              height: remainingHeight,
              width: draggableWidth,
              color: Colors.black,
            ),
          ],
        ),
        SizedBox(
          width: remainingWidth,
          height: Get.height,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
          ),
        )
      ],
    );
  }
}
