import 'package:summit_team/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// Widget للخلفية المشتركة في كل layouts
/// يستخدم const للتحسين الأداء
class AuthBackgroundWidget extends StatelessWidget {
  const AuthBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.richBlack,
              AppColors.charcoalBlack,
              AppColors.black,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SizedBox.expand(),
      ),
    );
  }
}
