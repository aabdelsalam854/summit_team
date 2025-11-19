import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';

import 'package:summit_team/features/Employees/presentation/widgets/legend_item_row.dart';

class RoleDistributionCard extends StatelessWidget {
  final int admins;
  final int accountants;
  final int employees;
  final int totalEmployees;

  const RoleDistributionCard({
    super.key,
    required this.admins,
    required this.accountants,
    required this.employees,
    required this.totalEmployees,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'توزيع الموظفين حسب الدور',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
                color: const Color(0xFF95A5A6),
              ),
            ],
          ),

          const SizedBox(height: 32),

          SizedBox(
            height: 280,
            child: Row(
              children: [
                // Pie Chart
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 60,
                        sections: [
                          PieChartSectionData(
                            value: admins.toDouble(),
                            title: '$admins',
                            color: const Color(0xFF9B59B6),
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            value: accountants.toDouble(),
                            title: '$accountants',
                            color: const Color(0xFFF39C12),
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            value: employees.toDouble(),
                            title: '$employees',
                            color: const Color(0xFF27AE60),
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: const SizedBox(width: 32),
                ),

                // Legend
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LegendItemRow(
                        label: 'مدراء',
                        count: admins,
                        total: totalEmployees,
                        color: const Color(0xFF9B59B6),
                      ),
                      Flexible(child: const SizedBox(height: 16)),
                      LegendItemRow(
                        label: 'محاسبين',
                        count: accountants,
                        total: totalEmployees,
                        color: const Color(0xFFF39C12),
                      ),
                      Flexible(child: const SizedBox(height: 16)),
                      LegendItemRow(
                        label: 'موظفين',
                        count: employees,
                        total: totalEmployees,
                        color: const Color(0xFF27AE60),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
