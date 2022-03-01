import 'package:digital_card_app/common/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authStateListener => _auth.authStateChanges();

  AuthService();

  Future<UserCredential?> signIn({
    required final String email,
    required final String password,
    VoidCallback? signInCallback,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email,password: password)
      .then((data) => {
        if (signInCallback != null) {
            Util.popUpToast(msg: 'Login Successful'),
            signInCallback(),
        }
      });
    } catch (e) {
      Util.popUpToast( 
        msg: 'Invalid Credentials'
      );
      print(e);
      print('Got an exception');
      return null;
    }
  }

  Future<UserCredential?> createUser({
    required final String email,
    required final String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (exception) {
      print('Got an exception');
      print(exception.toString());
      return null;
    }
  }

}
