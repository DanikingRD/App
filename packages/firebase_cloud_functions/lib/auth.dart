import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:firebase_cloud_functions/user/user.dart';

// A wrapper service over FirebaseAuth
class FirebaseAuthService {
  final FirebaseAuth _auth;
  const FirebaseAuthService(this._auth);

  /// Signs out the current user.
  ///
  /// If successful, it also updates [authStateChanges] stream
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// Attempts to sign in a user with the given email address and password.
  ///
  /// If successful, it also updates [authStateChanges] stream
  ///
  /// **Important**: You must enable Email & Password accounts in the Auth
  /// section of the Firebase console before being able to use them.
  ///
  /// A [FirebaseAuthException] maybe thrown for which you have some string outputs.
  ///
  Future<String> signIn({
    required String email,
    required String password,
    String? unknown,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "You've successfully logged in!";
    } on FirebaseAuthException catch (exception) {
      if (email.isEmpty || password.isEmpty) {
        return "The email and password fields are required";
      }
      switch (exception.code) {
        case "invalid-email":
          return FirebaseAuthMessage.invalidEmail;
        case "user-not-found":
          return FirebaseAuthMessage.emailNotFound;
        case "wrong-password":
          return FirebaseAuthMessage.wrongPassword;
        case "too-many-requests":
          return FirebaseAuthMessage.wrongPassword;
      }
      if (unknown == null) {
        return FirebaseAuthMessage.unknown;
      } else {
        return unknown;
      }
    }
  }

  /// Tries to create a new user account with the given email address and
  /// password.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **email-already-in-use**:
  ///  - Thrown if there already exists an account with the given email address.
  /// - **invalid-email**:
  ///  - Thrown if the email address is not valid.
  /// - **operation-not-allowed**:
  ///  - Thrown if email/password accounts are not enabled. Enable
  ///    email/password accounts in the Firebase Console, under the Auth tab.
  /// - **weak-password**:
  ///  - Thrown if the password is not strong enough.
  Future signUp({
    required String email,
    required String password,
    required String username,
    Uint8List? image,
  }) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user != null) {
        // We've successfully logged in
        final String uid = credentials.user!.uid;
        final String? url;
        if (image != null) {
          url = await FirebaseCloudServices.storageService.uploadImage(
            childName: "avatars",
            uid: uid,
            file: image,
          );
        } else {
          url = null;
        }
        // Upload to Firestore
        final FirestoreUser user = FirestoreUser(
          uid: uid,
          username: username,
          email: email,
          avatarURL: url,
        );
        await FirebaseCloudServices.database.users
            .doc(credentials.user!.uid)
            .set(user.toJson());
        return FirebaseAuthMessage.signedUp;
      }
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case "email-already-in-use":
          return FirebaseAuthMessage.emailAlreadyInUse;
        case "invalid-email":
          return FirebaseAuthMessage.invalidEmail;
        default:
          return FirebaseAuthMessage.unknown;
      }
    }
  }

  /// Notifies about changes to the user's sign-in state such as
  /// sign-in or sign-out, returning a [FirebaseUser] which could ben
  Stream<FirebaseUser?> authStateChanges() {
    return _auth.authStateChanges().map((event) {
      return event != null
          ? FirebaseUser(uid: event.uid, email: event.email!)
          : null;
    });
  }

  String findUserID() {
    return _auth.currentUser!.uid;
  }
}

class FirebaseAuthMessage {
  FirebaseAuthMessage._();
  // logging
  static const String loggedIn = "You've successfully logged in!";
  static const String emptyFields =
      "The email and password fields are required";
  static const String invalidEmail =
      "The email you've entered is invalid. Enter a valid email and try again.";
  static const String emailNotFound =
      "The email you've entered did not match our records. Please double-check or try creating a new account.";
  static const String wrongPassword =
      "The password you've entered did not match our records. Please double-check and try again.";
  static const String tooManyRequests =
      "You've done too many requests. Wait a few seconds and try again.";
  static const String unknown =
      "Unfortunately, an unknown error occurred. Apologies for the inconvenience.";
  //sign up
  static const String emailAlreadyInUse =
      "The email you've entered is already in use";
  static const String signedUp = "You've signed up successfully!";
}
