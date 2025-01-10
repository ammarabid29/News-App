import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Icon icon;
  final bool obscure;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final int? maxLines;
  const CustomFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    required this.validator,
    required this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon,
      ),
      validator: validator,
    );
  }
}
