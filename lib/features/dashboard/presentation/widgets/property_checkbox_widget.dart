import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';

/// ---------------------------------------------------------------------------
/// ☑️ PropertyCheckboxWidget — ويدجت الـ Checkbox في فورم العقار
/// ---------------------------------------------------------------------------

class PropertyCheckboxWidget extends StatelessWidget {
  const PropertyCheckboxWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AlessamyColors.primaryGold,
            checkColor: AlessamyColors.black,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              color: AlessamyColors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
