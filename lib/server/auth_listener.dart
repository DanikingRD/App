import 'package:firebase_auth/firebase_auth.dart';

class AuthListener {

  final FirebaseAuth _auth;

  const AuthListener(this._auth);

  Stream<User?> get users {
    return _auth.authStateChanges();
  }

}