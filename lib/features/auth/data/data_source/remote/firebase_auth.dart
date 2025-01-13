import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthSource({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> signinFromEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<User?> signupFromEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> logoutUser() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
