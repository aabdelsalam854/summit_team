import 'package:flutter/material.dart';

/// Widget للدوائر الديكورية في الخلفية
class DecorativeCircleWidget extends StatelessWidget {
  const DecorativeCircleWidget({
    super.key,
    required this.size,
    required this.color,
    this.opacity = 0.6,
  });

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: opacity * 0.5),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
      ),
    );
  }
}
