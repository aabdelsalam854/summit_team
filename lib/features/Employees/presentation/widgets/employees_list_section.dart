import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';
import 'package:summit_team/features/Employees/presentation/pages/employees_screen.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_card.dart';

class EmployeesListSection extends StatelessWidget {
  final List<Employee> employees;
  final bool isLoading;
  final VoidCallback onLoadMore;
  final VoidCallback onClearFilters;
  final EmployeeRole? selectedRole;
  final String searchQuery;

  const EmployeesListSection({
    super.key,
    required this.employees,
    required this.isLoading,
    required this.onLoadMore,
    required this.onClearFilters,
    required this.selectedRole,
    required this.searchQuery,
  });

  int _getCrossAxisCount(double width) {
    if (width < 600) return 1;
    if (width < 900) return 2;
    if (width < 1400) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = _getCrossAxisCount(width);

    return Card(
      color: AlessamyColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'قائمة الموظفين',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'إجمالي النتائج: ${employees.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF95A5A6),
                      ),
                    ),
                  ],
                ),

                if (selectedRole != null || searchQuery.isNotEmpty)
                  TextButton.icon(
                    onPressed: onClearFilters,
                    icon: const Icon(Icons.clear_all, color: Color(0xFFF1C40F)),
                    label: const Text(
                      'إلغاء الفلترة',
                      style: TextStyle(
                        color: Color(0xFFF1C40F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 24),

            /// EMPTY STATE
            if (!isLoading && employees.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 80,
                        color: const Color(0xFF95A5A6).withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'لا توجد نتائج',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF95A5A6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'جرب تغيير معايير البحث أو الفلترة',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF95A5A6),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              NotificationListener<ScrollNotification>(
                onNotification: (scroll) {
                  if (!isLoading &&
                      scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                    onLoadMore();
                  }
                  return false;
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isLoading && employees.isEmpty
                      ? _buildSkeletonGrid(crossAxisCount)
                      : _buildEmployeesGrid(crossAxisCount),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// GRID WHEN LOADED
  Widget _buildEmployeesGrid(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employees.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: .90,
      ),
      itemBuilder: (context, index) {
        final employee = employees[index];
        return AnimatedScale(
          scale: 1.0,
          duration: Duration(milliseconds: 250 + (index * 30)),
          child: AnimatedOpacity(
            opacity: 1,
            duration: Duration(milliseconds: 250 + (index * 30)),
            child: EmployeeCard(
              employee: employee,

              // onEdit: () {},
              // onDelete: () {},
            ),
          ),
        );
      },
    );
  }

  /// GRID SKELETON LOADING
  Widget _buildSkeletonGrid(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: crossAxisCount * 2,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}
