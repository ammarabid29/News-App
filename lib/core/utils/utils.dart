import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  void toastErrorMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void toastSuccessMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  AppBar customAppbar(BuildContext context, {required String title}) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }

  SpinKitChasingDots spinKit() {
    return SpinKitChasingDots(
      color: Colors.blue,
      size: 40,
    );
  }
}
