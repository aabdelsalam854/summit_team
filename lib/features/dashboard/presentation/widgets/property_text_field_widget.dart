import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';

/// ---------------------------------------------------------------------------
/// 📝 PropertyTextFieldWidget — ويدجت حقل النص في فورم العقار
/// ---------------------------------------------------------------------------

class PropertyTextFieldWidget extends StatelessWidget {
  const PropertyTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(color: AlessamyColors.white, fontSize: 15),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
            color: AlessamyColors.textLight,
            fontSize: 14,
          ),
          hintStyle: TextStyle(
            color: AlessamyColors.textLight.withValues(alpha: 0.5),
            fontSize: 13,
          ),
          prefixIcon: Icon(icon, color: AlessamyColors.primaryGold),
          filled: true,
          fillColor: AlessamyColors.backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AlessamyColors.primaryGold.withValues(alpha: 0.1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AlessamyColors.primaryGold,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
