
import 'package:flutter/material.dart';

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
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(width: 12),
        Text('($percentage)', style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}