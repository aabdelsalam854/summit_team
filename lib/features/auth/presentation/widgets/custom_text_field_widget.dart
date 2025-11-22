import 'package:summit_team/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.isMobile = false, this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isMobile;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(fontSize: 14, color: AppColors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 8, color: const Color(0XFFB5B7B6)),
        prefixIcon: Icon(
          prefixIcon,
          color: const Color(0XFFB5B7B6),
          size: 24,
        ),
        filled: true,
        fillColor: AppColors.textPrimary,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
