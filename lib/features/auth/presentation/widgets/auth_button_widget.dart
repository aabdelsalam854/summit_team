import 'package:summit_team/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// زر مخصص لتسجيل الدخول
class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.height = 50,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: AppColors.richBlack)
            : Text(
                text,
                style: const TextStyle(
                  color: AppColors.richBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
