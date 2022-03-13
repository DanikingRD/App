import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/cupertino.dart';

class AuthStateChangeNotifier extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get authInstance => _auth;

  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
    Function(String)? onError,
    Function(User?)? onSuccess,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (onSuccess != null) {
        onSuccess(credential.user);
      }
      return credential.user;
    } on FirebaseAuthException catch (exception) {
      if (onError != null) {
        if (email.isEmpty || password.isEmpty) {
          return onError(FirebaseAuthMessage.emptyFields);
        }
        final String output = FirebaseAuthMessage.getOutputFor(exception.code);
        onError(output);
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
    Function(String)? onError,
    Function(User?)? onSuccess,
  }) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (onSuccess != null) {
        onSuccess(credential.user);
      }
      return credential.user;
    } on FirebaseAuthException catch (exception) {
      if (onError != null) {
        if (email.isEmpty || password.isEmpty) {
          return onError(FirebaseAuthMessage.emptyFields);
        }
        final String output = FirebaseAuthMessage.getOutputFor(exception.code);
        onError(output);
      }
      return null;
    }
  }

  Future<void> logout({Function? onLogout}) async {
    await FirebaseAuth.instance.signOut();
    if (onLogout != null) {
      onLogout();
    }
  }
}
