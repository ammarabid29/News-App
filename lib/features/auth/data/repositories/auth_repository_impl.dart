import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/auth/data/data_source/remote/firebase_auth.dart';
import 'package:news_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthSource _firebaseAuthSource;

  AuthRepositoryImpl({FirebaseAuthSource? firebaseAuthSource})
      : _firebaseAuthSource = firebaseAuthSource ?? FirebaseAuthSource();

  @override
  Future<User?> signupUser(String email, String password) async {
    try {
      return await _firebaseAuthSource.signupFromEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> loginUser(String email, String password) async {
    try {
      return await _firebaseAuthSource.signinFromEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      return await _firebaseAuthSource.logoutUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  User? getCurrentUser() => _firebaseAuthSource.getCurrentUser();
}
