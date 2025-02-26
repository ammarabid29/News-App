import 'package:flutter/material.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/auth/domain/usecases/auth_use_cases.dart';

class SignupViewModel {
  final SignupUserUseCase signupUserUseCase;
  const SignupViewModel(this.signupUserUseCase);

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

  void handleSignup({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required Function(bool) setLoading,
  }) {
    setLoading(true);
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      signupUserUseCase
          .call(
        emailController.text.toString(),
        passwordController.text.toString(),
      )
          .then(
        (value) {
          setLoading(false);
          emailController.clear();
          passwordController.clear();
          Utils().toastSuccessMessage("Signup Successfully");
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      ).onError(
        (error, stackTrace) {
          setLoading(false);
          Utils().toastErrorMessage("Signup Failed $error");
        },
      );
    } else {
      setLoading(false);
      Utils().toastErrorMessage("Invalid Credentials");
    }
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pop();
  }
}
