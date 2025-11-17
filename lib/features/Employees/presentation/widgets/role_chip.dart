
import 'package:flutter/material.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';

class RoleChip extends StatelessWidget {
  final String label;
  final EmployeeRole? role;
  final EmployeeRole? selectedRole;
  final ValueChanged<EmployeeRole?> onSelected;

  const RoleChip({
    super.key,
    required this.label,
    required this.role,
    required this.selectedRole,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedRole == role;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        onSelected(selected ? role : null);
      },
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF1a1a2e) : Colors.white,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: const Color(0xFF1a1a2e),
      selectedColor: const Color(0xFFF1C40F),
      checkmarkColor: const Color(0xFF1a1a2e),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? const Color(0xFFF1C40F) : const Color(0xFF95A5A6),
          width: 1,
        ),
      ),
    );
  }
}
