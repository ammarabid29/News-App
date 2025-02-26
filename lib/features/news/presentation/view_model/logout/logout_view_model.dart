import 'package:flutter/material.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/auth/presentation/view/login/login_view.dart';
import 'package:news_app/features/news/domain/usecases/news_use_cases.dart';

class LogoutViewModel {
  final LogoutUserUseCase logoutUserUseCase;
  const LogoutViewModel(this.logoutUserUseCase);

  void logout(BuildContext context) {
    try {
      logoutUserUseCase.call();
      Utils().toastSuccessMessage("Logout Successfully");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginView(),
      ));
    } catch (e) {
      Utils().toastErrorMessage("Logout Failed $e");
    }
  }
}
