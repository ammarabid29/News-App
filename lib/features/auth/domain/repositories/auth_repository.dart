import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> loginUser(String email, String password);

  Future<User?> signupUser(String email, String password);

  Future<void> logoutUser();

  User? getCurrentUser();
}
