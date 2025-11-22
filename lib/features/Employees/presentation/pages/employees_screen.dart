import 'package:flutter/material.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_aashboard_app_bar.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_filter_section.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employee_form_dialog.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employees_list_section.dart';
import 'package:summit_team/features/Employees/presentation/widgets/employees_states_row.dart';
import 'package:summit_team/features/Employees/presentation/widgets/role_distribution_card.dart';

class EmployeesDeskTop extends StatelessWidget {
  final List<Employee> employees;
  final EmployeeRole? selectedRole;
  final String searchQuery;
  final ValueChanged<EmployeeRole?>? onRoleChanged;
  final ValueChanged<String>? onSearchChanged;

  const EmployeesDeskTop({
    super.key,
    required this.employees,
    this.selectedRole,
    this.searchQuery = '',
    this.onRoleChanged,
    this.onSearchChanged,
  });

  // int get _totalEmployees => employees.length;

  // int get _admins =>
  //     employees.where((e) => e.role == EmployeeRole.admin).length;

  // int get _accountants =>
  //     employees.where((e) => e.role == EmployeeRole.accountant).length;

  // int get _regularEmployees =>
  //     employees.where((e) => e.role == EmployeeRole.employee).length;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AlessamyColors.backgroundColor,
        body: Row(
          children: [
            // Expanded(flex: 1, child: CustomDrower()),
            Expanded(
              flex: 5,
              child: CustomScrollView(
                slivers: [
                  // App Bar
                  SliverAppBar(
                    backgroundColor: AlessamyColors.cardBackground,
                    pinned: true,
                    expandedHeight: 100,
                    toolbarHeight: 80,

                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),

                      title: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "SUMMIT TEAM",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                // controller: searchController,
                                decoration: InputDecoration(
                                  hintText: 'بحث...',
                                  prefixIcon: const Icon(Icons.search),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AlessamyColors.primaryGold,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'اسم المستخدم',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'دور المستخدم',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Main Content
                  SliverToBoxAdapter(
                    child: EmployeeDashboardAppBar(
                      lastUpdated: DateTime.now(),
                      onAddPressed: () => showDialog(
                        context: context,
                        builder: (context) =>
                            EmployeeFormDialog(employee: null),
                      ),
                    ),
                  ),
                  //  SliverToBoxAdapter(
                  //                   child: EmployeesStatesRowWidget(
                  //                                 totalEmployees: _totalEmployees,
                  //                                 admins: _admins,
                  //                                 accountants: _accountants,
                  //                                 employees: _regularEmployees,
                  //                               ),
                  //                 ),
                  SliverPadding(
                    padding: const EdgeInsets.all(24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Row 1: Stats Cards
                        // const SizedBox(height: 24),

                        // Row 2: Charts Row 1
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     // Expanded(
                        //     //   child: Padding(
                        //     //     padding: const EdgeInsets.all(16),
                        //     //     child: EmployeesStatesRowWidget(
                        //     //       totalEmployees: _totalEmployees,
                        //     //       admins: _admins,
                        //     //       accountants: _accountants,
                        //     //       employees: _regularEmployees,
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //     // const SizedBox(width: 40),
                        //     // Pie Chart - توزيع الموظفين
                        //     // Expanded(
                        //     //   child: RoleDistributionCard(
                        //     //     totalEmployees: _totalEmployees,
                        //     //     admins: _admins,
                        //     //     accountants: _accountants,
                        //     //     employees: _regularEmployees,
                        //     //   ),
                        //     // ),

                        //     // Bar Chart - نمو الموظفين شهرياً
                        //     // Expanded(flex: 3, child: _buildMonthlyGrowthCard()),
                        //   ],
                        // ),

                        // const SizedBox(height: 24),

                        // // Row 3: Charts Row 2
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     // Line Chart - اتجاه النمو
                        //     // Expanded(flex: 3, child: _buildGrowthTrendCard()),
                        //     const SizedBox(width: 24),
                        //     // Recent Employees
                        //     Expanded(
                        //       flex: 2,
                        //       child: _buildRecentEmployeesCard(),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 32),

                        // Filters Section
                        FiltersSection(
                          searchController: TextEditingController(
                            text: searchQuery,
                          ),
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
          ],
        ),
      ),
    );
  }
}
