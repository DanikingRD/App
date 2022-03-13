import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:firebase_cloud_functions/src/auth/provider/auth_provider.dart';
import 'package:firebase_cloud_functions/src/auth/provider/auth_state_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthManager extends StatelessWidget {
  final Widget login;
  final Widget home;

  ///An Authentication Gateway for your application
  ///
  ///If the User is logged in, it automatically redirects to the destinationFragment
  ///and if the user is not logged in, it redirects to the loginFragment
  ///can also accomodate a customWaitingScreen or a default one if needed.
  ///
  ///[loginFragment] (required) - The Login View
  ///
  ///[destinationFragment] (required) - The Destination View
  const AuthManager({
    Key? key,
    required this.login,
    required this.home,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<AuthStateChangeNotifier>(context);
    return StreamBuilder(
      stream: notifier.authInstance.authStateChanges(),
      builder: ((BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          return home;
        } else {
          return login;
        }
      }),
    );
  }
}
