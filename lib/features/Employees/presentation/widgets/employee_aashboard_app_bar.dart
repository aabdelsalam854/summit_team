import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/utils/app_styles.dart';

class EmployeeDashboardAppBar extends StatelessWidget {
  final VoidCallback onAddPressed;
  final DateTime lastUpdated;

  const EmployeeDashboardAppBar({
    super.key,
    required this.onAddPressed,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'لوحة تحكم الموظفين',
                style:  AppStyles.styleBold16(context)
                      .copyWith(color: AlessamyColors.white),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const SizedBox(width: 12),
                  Text(
                    'آخر تحديث: '
                    '${lastUpdated.hour}:${lastUpdated.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Color(0xFF95A5A6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Add Employee Button
          ElevatedButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add, size: 20),
            label:  Text(
              'إضافة موظف',
              style: AppStyles.styleBold16(context)
                      .copyWith(color: AlessamyColors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF1C40F),
              foregroundColor: const Color(0xFF0F1419),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
