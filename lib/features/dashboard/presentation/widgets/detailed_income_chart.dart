import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DetailedIncomeChart extends StatelessWidget {
  final ValueNotifier<int> activeIndexNotifier = ValueNotifier<int>(-1);

  DetailedIncomeChart({super.key});

  final List<_ChartItem> data = const [
    _ChartItem(label: 'المتاح', value: 40, color: Color(0xFF7BDCB5)),
    _ChartItem(label: 'المباع', value: 35, color: Color(0xFFF9A875)),
    _ChartItem(label: 'تم تأجيره', value: 25, color: Color(0xFFB58DF1)),
  ];

  @override
  Widget build(BuildContext context) {
    final total = data.fold<double>(0, (sum, e) => sum + e.value);

    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ValueListenableBuilder<int>(
            valueListenable: activeIndexNotifier,
            builder: (context, activeIndex, _) {
              return PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    enabled: true,
                    touchCallback: (event, response) {
                      if (!event.isInterestedForInteractions ||
                          response == null ||
                          response.touchedSection == null) {
                        activeIndexNotifier.value = -1;
                        return;
                      }
                      activeIndexNotifier.value =
                          response.touchedSection!.touchedSectionIndex;
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 120,
                  sections: List.generate(data.length, (i) {
                    final isActive = i == activeIndex;
                    final item = data[i];
                    return PieChartSectionData(
                      value: item.value,
                      color: item.color,
                      radius: isActive ? 90 : 85,
                      title: "${item.value}%",
                      titleStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isActive ? 18 : 14,
                        shadows: [const Shadow(color: Colors.black38, blurRadius: 3)],
                      ),
                    );
                  }),
                ),
                swapAnimationDuration: const Duration(milliseconds: 600),
                swapAnimationCurve: Curves.easeOutBack,
              );
            },
          ),
          // النص في المنتصف
          ValueListenableBuilder<int>(
            valueListenable: activeIndexNotifier,
            builder: (context, activeIndex, _) {
              final activeLabel =
                  activeIndex == -1 ? "الإجمالي" : data[activeIndex].label;
              final activeValue =
                  activeIndex == -1 ? total.toStringAsFixed(0) : "${data[activeIndex].value}%";

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    activeLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activeValue,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ChartItem {
  final String label;
  final double value;
  final Color color;
  const _ChartItem({
    required this.label,
    required this.value,
    required this.color,
  });
}

class IncomeLegend extends StatelessWidget {
  const IncomeLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildLegendItem(const Color(0xFF7BDCB5), 'المتاح'),
        const SizedBox(width: 16),
        buildLegendItem(const Color(0xFFF9A875), 'المباع'),
        const SizedBox(width: 16),
        buildLegendItem(const Color(0xFFB58DF1), 'تم تأجيره'),
      ],
    );
  }

  Widget buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
