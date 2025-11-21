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
    final cards = [
      DashboardStatsCard(
        title: 'إجمالي الموظفين',
        value: totalEmployees.toString(),
        icon: Icons.people,
        color: const Color(0xFF3498DB),
      ),
      DashboardStatsCard(
        title: 'مدراء',
        value: admins.toString(),
        icon: Icons.admin_panel_settings,
        color: const Color(0xFF9B59B6),
      ),
      DashboardStatsCard(
        title: 'محاسبين',
        value: accountants.toString(),
        icon: Icons.account_balance,
        color: const Color(0xFFF39C12),
      ),
      DashboardStatsCard(
        title: 'موظفين',
        value: employees.toString(),
        icon: Icons.person,
        color: const Color(0xFF27AE60),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        double widthFactor = width < 600 ? 0.48 : 0.24;

        if (width < 800) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(child: cards[0]),
                  const SizedBox(width: 12),
                  Expanded(child: cards[1]),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: cards[2]),
                  const SizedBox(width: 12),
                  Expanded(child: cards[3]),
                ],
              ),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: cards
                  .map(
                    (card) => FractionallySizedBox(
                      widthFactor: widthFactor,
                      child: card,
                    ),
                  )
                  .toList(),
            ),
          );
        }
      },
    );
  }
}
