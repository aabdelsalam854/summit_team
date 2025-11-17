import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';
import 'package:summit_team/features/Employees/presentation/pages/employees_screen.dart';

class FiltersSection extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final EmployeeRole? selectedRole;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<EmployeeRole?> onRoleChanged;

  const FiltersSection({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.selectedRole,
    required this.onSearchChanged,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AlessamyColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2C3E50), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 Search Field
            TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'بحث بالاسم أو رقم الهاتف...',
                hintStyle: const TextStyle(color: Color(0xFF95A5A6)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFF1C40F)),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Color(0xFF95A5A6)),
                        onPressed: () {
                          searchController.clear();
                          onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF1a1a2e),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF2C3E50),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFF1C40F),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Title
            const Text(
              'تصفية حسب الدور الوظيفي:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            /// Role Chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                RoleChip(
                  label: 'الكل',
                  role: null,
                  selectedRole: selectedRole,
                  onSelected: onRoleChanged,
                ),
                RoleChip(
                  label: 'مدير',
                  role: EmployeeRole.admin,
                  selectedRole: selectedRole,
                  onSelected: onRoleChanged,
                ),
                RoleChip(
                  label: 'محاسب',
                  role: EmployeeRole.accountant,
                  selectedRole: selectedRole,
                  onSelected: onRoleChanged,
                ),
                RoleChip(
                  label: 'موظف',
                  role: EmployeeRole.employee,
                  selectedRole: selectedRole,
                  onSelected: onRoleChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
