import 'package:flutter/material.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:news_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:news_app/features/auth/presentation/view/signup/signup_view.dart';
import 'package:news_app/features/news/presentation/view/all_news/all_news_view.dart';

class LoginViewModel {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter email";
    } else if (!value.contains("@") || !value.contains(".")) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter password";
    } else if (value.length < 6) {
      return "Password length should greater than 6";
    }
    return null;
  }

  void navigateToSignupScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignupView(),
      ),
    );
  }

  void handleLogin({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required Function(bool) setLoading,
  }) {
    setLoading(true);
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      _authRepository
          .loginUser(emailController.text, passwordController.text)
          .then(
        (value) {
          emailController.clear();
          passwordController.clear();
          Utils().toastSuccessMessage("Login Successfully");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => AllNewsView(),
            ),
          );
          setLoading(false);
        },
      ).onError(
        (error, stackTrace) {
          Utils().toastErrorMessage("Login Failed $error");
          setLoading(false);
        },
      );
    } else {
      setLoading(false);
      Utils().toastErrorMessage("Invalid Credentials");
    }
  }
}
