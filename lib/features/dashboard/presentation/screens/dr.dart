import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/utils/app_styles.dart';

class PropertyStats {
  final int available;
  final int rented;
  final int sold;

  PropertyStats({
    required this.available,
    required this.rented,
    required this.sold,
  });

  int get total => available + rented + sold;
}

enum PropertyType {
  villa('فلل'),
  apartment('شقق'),
  shop('محلات'),
  land('أراضي');

  final String arabicName;
  const PropertyType(this.arabicName);
}

class PropertyTypeStats {
  final PropertyType type;
  final PropertyStats stats;

  PropertyTypeStats({required this.type, required this.stats});
}

class PropertyStatsChart extends StatefulWidget {
  final Map<PropertyType, PropertyStats> propertyData;

  const PropertyStatsChart({super.key, required this.propertyData});

  @override
  State<PropertyStatsChart> createState() => _PropertyStatsChartState();
}

class _PropertyStatsChartState extends State<PropertyStatsChart> {
  late final ValueNotifier<PropertyType> selectedTypeNotifier;

  @override
  void initState() {
    super.initState();
    selectedTypeNotifier = ValueNotifier<PropertyType>(PropertyType.villa);
  }

  @override
  void dispose() {
    selectedTypeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildTypeSelector(),
          const SizedBox(height: 32),
          AspectRatio(
            aspectRatio: 1.5,
            child: _buildChart(),
          ),
          const SizedBox(height: 24),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return ValueListenableBuilder<PropertyType>(
      valueListenable: selectedTypeNotifier,
      builder: (context, selectedType, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  'إحصائيات العقارات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF3498DB).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'إجمالي: ${widget.propertyData[selectedType]?.total ?? 0}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3498DB),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTypeSelector() {
    return ValueListenableBuilder<PropertyType>(
      valueListenable: selectedTypeNotifier,
      builder: (context, selectedType, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: PropertyType.values.map((type) {
              final isSelected = selectedType == type;
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ChoiceChip(
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      type.arabicName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      selectedTypeNotifier.value = type;
                    }
                  },
                  selectedColor: AlessamyColors.borderGold,
                  backgroundColor: Colors.grey.shade200,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: isSelected ? 4 : 0,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildChart() {
    return ValueListenableBuilder<PropertyType>(
      valueListenable: selectedTypeNotifier,
      builder: (context, selectedType, _) {
        final stats = widget.propertyData[selectedType];
        if (stats == null) {
          return Center(
            child: FittedBox(
              child: Text(
                'لا توجد بيانات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        return BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: _getMaxY(stats),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (group) => const Color(0xFF2C3E50),
                tooltipBorder: const BorderSide(color: Colors.transparent),
                tooltipPadding: const EdgeInsets.all(8),
                tooltipMargin: 8,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String label = '';
                  switch (groupIndex) {
                    case 0:
                      label = 'متاح';
                      break;
                    case 1:
                      label = 'مؤجر';
                      break;
                    case 2:
                      label = 'مباع';
                      break;
                  }
                  return BarTooltipItem(
                    '$label\n${rod.toY.toInt()}',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) =>
                      _getBottomTitles(value, meta, context: context),
                  reservedSize: 42,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: _getInterval(stats),
                  getTitlesWidget: (value, meta) {
                    return FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          color: Color(0xFF7F8C8D),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: _getInterval(stats),
              getDrawingHorizontalLine: (value) {
                return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
              },
            ),
            borderData: FlBorderData(show: false),
            barGroups: [
              _buildBarGroup(
                0,
                stats.available.toDouble(),
                const Color(0xFF7BDCB5),
                stats,
              ),
              _buildBarGroup(
                1,
                stats.rented.toDouble(),
                const Color(0xFFF9A875),
                stats,
              ),
              _buildBarGroup(
                2,
                stats.sold.toDouble(),
                const Color(0xFFB58DF1),
                stats,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getBottomTitles(
    double value,
    TitleMeta meta, {
    required BuildContext context,
  }) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'متاح';
        break;
      case 1:
        text = 'مؤجر';
        break;
      case 2:
        text = 'مباع';
        break;
      default:
        text = '';
    }
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: AppStyles.styleBold16(context).copyWith(
          color: const Color(0xFF2C3E50),
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y, Color color, PropertyStats stats) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 40,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: _getMaxY(stats),
            color: Colors.grey.shade200,
          ),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return ValueListenableBuilder<PropertyType>(
      valueListenable: selectedTypeNotifier,
      builder: (context, selectedType, _) {
        final stats = widget.propertyData[selectedType];

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: _buildLegendItem('متاح', const Color(0xFF7BDCB5), stats),
            ),
            Flexible(
              child: _buildLegendItem('مؤجر', const Color(0xFFF9A875), stats),
            ),
            Flexible(
              child: _buildLegendItem('مباع', const Color(0xFFB58DF1), stats),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLegendItem(String label, Color color, PropertyStats? stats) {
    int value = 0;

    if (stats != null) {
      if (label == 'متاح') value = stats.available;
      if (label == 'مؤجر') value = stats.rented;
      if (label == 'مباع') value = stats.sold;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value.toString(),
                  style: AppStyles.styleBold16(context).copyWith(
                    color: const Color(0xFF2C3E50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _getMaxY(PropertyStats stats) {
    final max = [
      stats.available,
      stats.rented,
      stats.sold,
    ].reduce((a, b) => a > b ? a : b);
    return (max * 1.2).ceilToDouble();
  }

  double _getInterval(PropertyStats stats) {
    final maxY = _getMaxY(stats);
    if (maxY <= 10) return 2;
    if (maxY <= 50) return 10;
    if (maxY <= 100) return 20;
    return 50;
  }
}