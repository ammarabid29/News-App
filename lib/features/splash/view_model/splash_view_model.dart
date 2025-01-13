import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:news_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:news_app/features/auth/presentation/view/login/login_view.dart';
import 'package:news_app/features/news/presentation/view/all_news/all_news_view.dart';

class SplashViewModel {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  void isLogin(BuildContext context) {
    final user = _authRepository.getCurrentUser();

    if (user != null) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => AllNewsView(),
          ),
        );
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => LoginView(),
          ),
        );
      });
    }
  }
}
