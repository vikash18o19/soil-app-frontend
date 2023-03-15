import 'package:flutter/material.dart';
import 'package:soil_app/utils/Colors.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppColors.c3,
        decoration: InputDecoration(
          fillColor: AppColors.c0,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.c4),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.c0,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.c0),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
