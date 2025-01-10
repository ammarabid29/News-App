import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        backgroundColor: Colors.deepPurple,
      ),
      onPressed: onTap,
      child: isLoading
          ? SizedBox(
              height: 30,
              width: 35,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
    );
  }
}