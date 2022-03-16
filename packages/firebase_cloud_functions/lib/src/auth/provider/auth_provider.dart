import 'package:firebase_cloud_functions/src/auth/provider/auth_state_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FirebaseAuthProvider extends StatelessWidget {
  // Material App
  final Widget? child;
  final Widget Function(BuildContext, Widget?)? builder;

  ///Exposes the FirebaseAuthProvider to the whole widget tree
  ///
  ///You MUST put this above the MaterialApp widget to ensure the whole widget tree
  ///has access to the AuthenticationProvider.
  ///
  ///This is a compulsary widget as the AuthController and AuthManager depends on it.
  ///
  ///Although you won't need it, You can access the FireAuthProvider like this:
  ///
  ///```dart
  ///final provider = Provider.of<FireAuthProvider>(context, listen:false);
  ///```
  ///
  ///[child] is your MaterialApp
  const FirebaseAuthProvider({
    Key? key,
    this.child,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthStateChangeNotifier(),
      builder: builder,
      child: child,
    );
  }
}
