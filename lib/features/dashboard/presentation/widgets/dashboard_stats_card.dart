import 'package:flutter/material.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/utils/app_styles.dart';

/// ---------------------------------------------------------------------------
/// 📊 DashboardStatsCard — بطاقة الإحصائيات في الداشبورد
/// ---------------------------------------------------------------------------
class DashboardStatsCard extends StatelessWidget {
  const DashboardStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child:  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
  children: [
    // Icon
    Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        
        child: Icon(icon, size: 28, color: color)),
    ),

    const SizedBox(height: 16),

    // VALUE (مرن)
    Flexible(
      fit: FlexFit.loose,   
      child: Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.styleBold16(context)
            .copyWith(color: AlessamyColors.white),
      ),
    ),

    const SizedBox(height: 6),

    // TITLE (مرن)
    Flexible(
      fit: FlexFit.loose,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.styleRegular14(context)
            .copyWith(color: AlessamyColors.textLight),
      ),
    ),
  ],
),

    );
  }
}
