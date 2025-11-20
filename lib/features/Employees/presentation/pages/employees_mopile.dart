import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';

import 'package:summit_team/features/Employees/presentation/widgets/employee_aashboard_app_bar.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_filter_section.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_form_dialog.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employees_list_section.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employees_states_row.dart';
import 'package:summit_team/features/Employees/presentation/widgets/role_distribution_card.dart';

class EmployeesMopile extends StatelessWidget {
  final List<Employee> employees;
  final EmployeeRole? selectedRole;
  final String searchQuery;
  final ValueChanged<EmployeeRole?>? onRoleChanged;
  final ValueChanged<String>? onSearchChanged;

  const EmployeesMopile({
    super.key,
    required this.employees,
    this.selectedRole,
    this.searchQuery = '',
    this.onRoleChanged,
    this.onSearchChanged,
  });

  int get _totalEmployees => employees.length;

  int get _admins =>
      employees.where((e) => e.role == EmployeeRole.admin).length;

  int get _accountants =>
      employees.where((e) => e.role == EmployeeRole.accountant).length;

  int get _regularEmployees =>
      employees.where((e) => e.role == EmployeeRole.employee).length;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AlessamyColors.backgroundColor,
        body: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: EmployeeDashboardAppBar(
                lastUpdated: DateTime.now(),
                onAddPressed: () => showDialog(
                  context: context,
                  builder: (context) => EmployeeFormDialog(employee: null),
                ),
              ),
            ),

            // Main Content
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 24),

                  // Statistics Cards - Mobile Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: EmployeesStatesRowWidget(
                          totalEmployees: _totalEmployees,
                          admins: _admins,
                          accountants: _accountants,
                          employees: _regularEmployees,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        color: AlessamyColors.cardBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: RoleDistributionCard(
                            totalEmployees: _totalEmployees,
                            admins: _admins,
                            accountants: _accountants,
                            employees: _regularEmployees,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Filters Section
                  FiltersSection(
                    searchController: TextEditingController(text: searchQuery),
                    searchQuery: searchQuery,
                    selectedRole: selectedRole,
                    onSearchChanged: onSearchChanged!,
                    onRoleChanged: onRoleChanged!,
                  ),

                  const SizedBox(height: 24),

                  // Employees List
                  EmployeesListSection(
                    employees: employees,
                    isLoading: false,
                    selectedRole: selectedRole,
                    searchQuery: searchQuery,
                    onClearFilters: () {
                      onRoleChanged?.call(null);
                      onSearchChanged?.call('');
                    },
                    onLoadMore: () {},
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
