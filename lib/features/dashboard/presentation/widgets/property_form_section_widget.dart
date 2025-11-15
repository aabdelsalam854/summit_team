import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';

/// ---------------------------------------------------------------------------
/// 📦 PropertyFormSectionWidget — ويدجت القسم في فورم العقار
/// ---------------------------------------------------------------------------

class PropertyFormSectionWidget extends StatelessWidget {
  const PropertyFormSectionWidget({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AlessamyColors.primaryGold.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AlessamyColors.white,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
