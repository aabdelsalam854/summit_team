
import 'package:flutter/material.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/dashboard_stats_card.dart';

class EmployeesStatesRowWidget extends StatelessWidget {
  const EmployeesStatesRowWidget({
    super.key,
    required this.totalEmployees,
    required this.admins,
    required this.accountants,
    required this.employees,
  });

  final int totalEmployees;
  final int admins;
  final int accountants;
  final int employees;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardStatsCard(
                  title: 'إجمالي الموظفين',
                  value: totalEmployees.toString(),
                  icon: Icons.people,
                  color: const Color(0xFF3498DB),
                  // subtitle: '+$newThisMonth موظف جديد',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardStatsCard(
                  title: 'مدراء',
                  value: admins.toString(),
                  icon: Icons.admin_panel_settings,
                  color: const Color(0xFF9B59B6),
                  // subtitle:
                  //     '${((admins / totalEmployees) * 100).toStringAsFixed(1)}% من الإجمالي',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DashboardStatsCard(
                  title: 'محاسبين',
                  value: accountants.toString(),
                  icon: Icons.account_balance,
                  color: const Color(0xFFF39C12),
                  // subtitle:
                  //     '${((accountants / totalEmployees) * 100).toStringAsFixed(1)}% من الإجمالي',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardStatsCard(
                  title: 'موظفين',
                  value: employees.toString(),
                  icon: Icons.person,
                  color: const Color(0xFF27AE60),
                  // :
                  //     '${((employees / totalEmployees) * 100).toStringAsFixed(1)}% من الإجمالي',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}