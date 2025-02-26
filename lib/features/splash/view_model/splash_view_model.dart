import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/features/auth/presentation/view/login/login_view.dart';
import 'package:news_app/features/news/data/repositories/news_repository_imp.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/presentation/view/all_news/all_news_view.dart';

class SplashViewModel {
  final NewsRepository _newsRepository = NewsRepositoryImp();

  void isLogin(BuildContext context) {
    final user = _newsRepository.getCurrentUser();
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
