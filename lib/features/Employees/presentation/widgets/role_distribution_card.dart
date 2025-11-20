import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';

import 'package:summit_team/features/Employees/presentation/widgets/legend_item_row.dart';

class RoleDistributionCard extends StatefulWidget {
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
  State<RoleDistributionCard> createState() => _RoleDistributionCardState();
}

class _RoleDistributionCardState extends State<RoleDistributionCard> {
  final ValueNotifier<int> activeIndexNotifier = ValueNotifier<int>(-1);

  final List<_RoleData> roles = [];

  @override
  void initState() {
    super.initState();
    roles.addAll([
      _RoleData(
        label: 'مدراء',
        value: widget.admins,
        color: const Color(0xFF9B59B6),
      ),
      _RoleData(
        label: 'محاسبين',
        value: widget.accountants,
        color: const Color(0xFFF39C12),
      ),
      _RoleData(
        label: 'موظفين',
        value: widget.employees,
        color: const Color(0xFF27AE60),
      ),
    ]);
  }

  @override
  void dispose() {
    activeIndexNotifier.dispose();
    super.dispose();
  }

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
              const Expanded(
                child: Text(
                  'توزيع الموظفين حسب الدور',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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

          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              
              // لو العرض أقل من 350، نخفي الـ Chart
              if (width < 350) {
                return _buildLegendOnly();
              }
              
              // لو العرض أقل من 500، نعرض الـ Chart فوق والـ Legend تحت
              if (width < 500) {
                return _buildVerticalLayout();
              }
              
              // العرض كبير - Layout الأصلي
              return _buildHorizontalLayout();
            },
          ),
        ],
      ),
    );
  }

  // Layout أفقي (الأصلي)
  Widget _buildHorizontalLayout() {
    return SizedBox(
      height: 280,
      child: Row(
        children: [
          // Pie Chart
          Expanded(
            flex: 2,
            child: _buildChart(),
          ),

          const SizedBox(width: 32),

          // Legend
          Expanded(
            child: _buildLegend(),
          ),
        ],
      ),
    );
  }

  // Layout عمودي (للشاشات الصغيرة)
  Widget _buildVerticalLayout() {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: _buildChart(),
        ),
        const SizedBox(height: 24),
        _buildLegend(),
      ],
    );
  }

  // Legend فقط (للشاشات الصغيرة جداً)
  Widget _buildLegendOnly() {
    return _buildLegend();
  }

  // الـ Chart
  Widget _buildChart() {
    return ValueListenableBuilder<int>(
      valueListenable: activeIndexNotifier,
      builder: (context, activeIndex, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    enabled: true,
                    touchCallback: (event, response) {
                      activeIndexNotifier.value =
                          response?.touchedSection?.touchedSectionIndex ?? -1;
                    },
                  ),
                  sectionsSpace: 2,
                  centerSpaceRadius: 60,
                  sections: List.generate(roles.length, (i) {
                    final role = roles[i];
                    final isActive = activeIndex == i;
                    return PieChartSectionData(
                      value: role.value.toDouble(),
                      title: '${role.value}',
                      color: role.color,
                      radius: isActive ? 70 : 60,
                      titleStyle: TextStyle(
                        fontSize: isActive ? 20 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
                swapAnimationDuration: const Duration(milliseconds: 300),
                swapAnimationCurve: Curves.easeInOut,
              ),
            ),
            // النص في المنتصف
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  activeIndex >= 0 ? roles[activeIndex].label : 'الأدوار',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (activeIndex >= 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${((roles[activeIndex].value / widget.totalEmployees) * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: roles[activeIndex].color,
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }

  // الـ Legend
  Widget _buildLegend() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LegendItemRow(
          label: 'مدراء',
          count: widget.admins,
          total: widget.totalEmployees,
          color: const Color(0xFF9B59B6),
        ),
        const SizedBox(height: 16),
        LegendItemRow(
          label: 'محاسبين',
          count: widget.accountants,
          total: widget.totalEmployees,
          color: const Color(0xFFF39C12),
        ),
        const SizedBox(height: 16),
        LegendItemRow(
          label: 'موظفين',
          count: widget.employees,
          total: widget.totalEmployees,
          color: const Color(0xFF27AE60),
        ),
      ],
    );
  }
}

class _RoleData {
  final String label;
  final int value;
  final Color color;

  const _RoleData({
    required this.label,
    required this.value,
    required this.color,
  });
}