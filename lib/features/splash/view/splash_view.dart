import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/utils/utils.dart';
import 'package:news_app/features/splash/view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashViewModel _splashViewModel = SplashViewModel();

  @override
  void initState() {
    super.initState();
    _splashViewModel.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/splash_pic.jpg",
            fit: BoxFit.cover,
            height: height * .5,
          ),
          SizedBox(height: height * 0.04),
          Text(
            "TOP-HEADLINES",
            style: GoogleFonts.anton(
                letterSpacing: .6, color: Colors.grey.shade700),
          ),
          SizedBox(height: height * 0.04),
          Utils().spinKit(),
        ],
      ),
    );
  }
}
