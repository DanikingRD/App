import 'package:digital_card_app/common/colors.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:flutter/material.dart';

class NavigationButton extends FloatingActionButton {
  NavigationButton({
    Key? key,
    required VoidCallback? onPressed,
    required NavigationDir dir,
    Object? heroTag,
    double elevation = 5.0,
    Color? backgroundColor = homeColor,
    Color? foregroundColor = Colors.white,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: Icon(getIcon(dir)),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: elevation,
          heroTag: heroTag,
          highlightElevation: 0.0,
        );

  static IconData getIcon(NavigationDir dir) {
    switch (dir) {
      case NavigationDir.next:
        {
          return Icons.navigate_next_outlined;
        }
      case NavigationDir.previous:
        {
          return Icons.navigate_before_outlined;
        }
    }
  }
}

class TransparentNavigationButton extends NavigationButton {
  TransparentNavigationButton({
    Key? key,
    required VoidCallback? onPressed,
    required NavigationDir dir,
    Object? heroTag,
    double elevation = 0.0,
    Color? backgroundColor = Colors.transparent,
    Color? foregroundColor = homeColor,
  }) : super(
          dir: dir,
          key: key,
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: elevation,
          heroTag: heroTag,
        );
}

class LockedNavigationButton extends NavigationButton {
  LockedNavigationButton({
    Key? key,
    required NavigationDir dir,
    Object? heroTag,
    double elevation = 5.0,
    Color? backgroundColor = lockedFloatingButtonColor,
    Color? foregroundColor = Colors.white,
  }) : super(
          dir: dir,
          key: key,
          onPressed: null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: elevation,
          heroTag: heroTag,
        );
}
