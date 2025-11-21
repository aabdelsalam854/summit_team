import 'package:flutter/material.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.itemBuilder,
  });

  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AlessamyColors.textSecondary,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AlessamyColors.borderLight),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              dropdownColor: AlessamyColors.charcoalBlack,
              value: value,
              isExpanded: true,
              hint: Text(
                'اختر $label',
                style: TextStyle(fontSize: 14, color: AlessamyColors.textLight),
              ),
              items: items.map((item) {
                return DropdownMenuItem<T>(

                  value: item,
                  child: Text(
                    itemBuilder(item),
                    style: TextStyle(
                      fontSize: 14,
                      color: AlessamyColors.white,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
