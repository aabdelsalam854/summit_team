import 'package:flutter/material.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';

/// ---------------------------------------------------------------------------
/// 📅 PropertyDatePickerWidget — ويدجت اختيار التاريخ في فورم العقار
/// ---------------------------------------------------------------------------

class PropertyDatePickerWidget extends StatelessWidget {
  const PropertyDatePickerWidget({
    super.key,
    required this.label,
    required this.date,
    required this.onChanged,
  });

  final String label;
  final DateTime? date;
  final void Function(DateTime?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: date ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: AlessamyColors.primaryGold,
                    surface: AlessamyColors.cardBackground,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            onChanged(picked);
          }
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AlessamyColors.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AlessamyColors.primaryGold.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: AlessamyColors.primaryGold,
                size: 20,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: AlessamyColors.textLight,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      date != null
                          ? '${date!.year}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}'
                          : 'اختر التاريخ',
                      style: TextStyle(
                        color: date != null
                            ? AlessamyColors.white
                            : AlessamyColors.textLight.withValues(alpha: 0.5),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
