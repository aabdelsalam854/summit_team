
import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/utils/app_styles.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onViewAll;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // هذا الجزء مرن الآن
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Text(
                    title,
                    style: AppStyles.styleSemiBold20(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 6),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    subtitle,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // زر View All
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: TextButton(
              onPressed: onViewAll,
              child: Text(
                'عرض الكل',
                style: AppStyles.styleSemiBold16(context).copyWith(
                  color: AlessamyColors.primaryGold,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              // style: TextButton.styleFrom(
              //   backgroundColor: Colors.amber, // ممكن تخليها شفافة لو تحب
              //   padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(14),
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}