import 'package:summit_team/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AuthFormCardWidget extends StatelessWidget {
  const AuthFormCardWidget({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(32),
    this.borderRadius = 25,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
