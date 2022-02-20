import 'package:flutter/widgets.dart';

class RegistrationPageTransition extends PageRouteBuilder {
  final Widget child;

  RegistrationPageTransition({
    required this.child,
  }) : super(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (ctx, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child)
   => ScaleTransition(
      scale: animation,
      child: child,
    );
    
}
