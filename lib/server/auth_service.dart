import 'package:digital_card_app/common/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth;
  Stream<User?> get authStateListener => _auth.authStateChanges();
  
  AuthService(this._auth);

  Future<UserCredential?> signIn(final String email, final String password) async {
    try {
        return await _auth.signInWithEmailAndPassword(email: email, password: password);
      } catch (exception) {
        print(exception.toString());
        return null;
      }
    }

  Future<UserCredential?> createUser(final String email, final String password) async {
    try {
        return await _auth.createUserWithEmailAndPassword(email: email, password: password);
      } catch (exception) {
        print(exception.toString());
        return null;
    }
  }
    Future<CustomUser?> logInAnonymously() async {
    try {
        final credentials = await _auth.signInAnonymously();
        return _fromFirebase(credentials);
      } catch (exception) {
        print(exception.toString());
        return null;
    }
  }
  CustomUser? _fromFirebase(UserCredential credentials) {
    return CustomUser(uid: credentials.user!.uid);
  }
}
