import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/view/all_news/all_news_view.dart';

class SplashViewModel {
  void isLogin(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => AllNewsView(),
        ),
      );
    });

    // final FirebaseAuth auth = FirebaseAuth.instance;

    // final user = auth.currentUser;

    // if (user != null) {
    //   Timer(Duration(seconds: 2), () {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (ctx) => FireStoreListScreen(),
    //       ),
    //     );
    //   });
    // } else {
    //   Timer(Duration(seconds: 2), () {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (ctx) => LoginScreen(),
    //       ),
    //     );
    //   });
  }
}
