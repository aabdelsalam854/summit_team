import 'package:flutter/material.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';

/// ---------------------------------------------------------------------------
/// 📋 PropertyDropdownWidget — ويدجت القائمة المنسدلة في فورم العقار
/// ---------------------------------------------------------------------------

class PropertyDropdownWidget<T> extends StatelessWidget {
  const PropertyDropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    required this.icon,
  });

  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T?) onChanged;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<T>(
        initialValue: value,
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(
              itemLabel(item),
              style: TextStyle(color: AlessamyColors.white, fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AlessamyColors.textLight, fontSize: 14),
          prefixIcon: Icon(icon, color: AlessamyColors.primaryGold),
          filled: true,
          fillColor: AlessamyColors.backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AlessamyColors.primaryGold.withValues(alpha: 0.1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AlessamyColors.primaryGold, width: 2),
          ),
        ),
        dropdownColor: AlessamyColors.cardBackground,
        style: TextStyle(color: AlessamyColors.white, fontSize: 15),
      ),
    );
  }
}
