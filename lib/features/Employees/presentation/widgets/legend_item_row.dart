import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/app_styles.dart';

class LegendItemRow extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;

  const LegendItemRow({
    super.key,
    required this.label,
    required this.count,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = total == 0
        ? '0%'
        : '${((count / total) * 100).toStringAsFixed(1)}%';

    return Row(
      children: [
        // الدائرة الملونة
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        
        // النص
        Flexible(
          child: Text(
            label,
            style: AppStyles.styleRegular14(context)
                .copyWith(color: Colors.white),
          ),
        ),
        
        const SizedBox(width: 12),
        
        // النسبة المئوية
        Text(
          '($percentage)',
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}