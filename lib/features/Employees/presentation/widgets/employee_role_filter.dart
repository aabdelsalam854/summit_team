import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';
import 'package:summit_team/features/Employees/presentation/cubit/employees_cubit.dart';

class EmployeeRoleFilter extends StatelessWidget {
  const EmployeeRoleFilter({super.key});

  Color _getRoleColor(EmployeeRole role) {
    switch (role) {
      case EmployeeRole.admin:
        return Colors.red.shade700;
      case EmployeeRole.accountant:
        return Colors.blue.shade700;
      case EmployeeRole.employee:
        return Colors.green.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeesCubit, EmployeesState>(
      builder: (context, state) {
        final selectedRole = state is EmployeesLoaded ? state.filteredRole : null;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // All Employees Chip
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: FilterChip(
                  label: const Text('الكل'),
                  selected: selectedRole == null,
                  onSelected: (selected) {
                    if (selected) {
                      context.read<EmployeesCubit>().clearFilter();
                    }
                  },
                  selectedColor: Colors.grey.shade700,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selectedRole == null ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Role Filter Chips
              ...EmployeeRole.values.map((role) {
                final isSelected = selectedRole == role;
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterChip(
                    avatar: Icon(
                      _getRoleIcon(role),
                      color: isSelected ? Colors.white : _getRoleColor(role),
                      size: 20,
                    ),
                    label: Text(role.arabicName),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        context.read<EmployeesCubit>().getEmployeesByRole(role);
                      }
                    },
                    selectedColor: _getRoleColor(role),
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  IconData _getRoleIcon(EmployeeRole role) {
    switch (role) {
      case EmployeeRole.admin:
        return Icons.admin_panel_settings;
      case EmployeeRole.accountant:
        return Icons.supervisor_account;
      case EmployeeRole.employee:
        return Icons.person;
    }
  }
}
