import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:news_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:news_app/features/auth/presentation/view/login/login_view.dart';

class LogoutViewModel {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  void logout(BuildContext context) {
    try {
      _authRepository.logoutUser();
      Utils().toastSuccessMessage("Logout Successfully");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginView(),
      ));
    } catch (e) {
      if (kDebugMode) {
        print('Logout failed: $e');
      }
    }
  }
}
