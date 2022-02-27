import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authStateListener => _auth.authStateChanges();

  AuthService();

  Future<UserCredential?> signIn({
    required final String email,
    required final String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
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
      print(exception.toString());
      return null;
    }
  }
}
