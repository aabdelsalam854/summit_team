import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/utils/app_styles.dart';

class CustomAppBarSliever extends StatelessWidget {
  const CustomAppBarSliever({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final isTablet =
        MediaQuery.of(context).size.width >= 900 &&
        MediaQuery.of(context).size.width < 1200;

    return SliverAppBar(
      backgroundColor: AlessamyColors.cardBackground,
      pinned: true,
      expandedHeight: isMobile ? 80 : 100,
      toolbarHeight: isMobile ? 60 : 80,

      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 24,
          vertical: isMobile ? 8 : 12,
        ),
        title: isMobile
            ? _buildMobileLayout(context)
            : isTablet
            ? _buildTabletLayout(context)
            : _buildDesktopLayout(context),
      ),
    );
  }

  /// موبايل: العنوان + أيقونة المستخدم فقط
  Widget _buildMobileLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "SUMMIT TEAM",
            style: AppStyles.styleBold18(
              context,
            ).copyWith(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 18,
          backgroundColor: AlessamyColors.primaryGold,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  /// تابلت: العنوان + بحث + أيقونة المستخدم
  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Text(
            "SUMMIT TEAM",
            style: AppStyles.styleBold18(context).copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 3,
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'بحث...',
                hintStyle: const TextStyle(fontSize: 14),
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        CircleAvatar(
          radius: 18,
          backgroundColor: AlessamyColors.primaryGold,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.person, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  /// ديسكتوب: كل شيء (العنوان + بحث + معلومات المستخدم كاملة)
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Flexible(
          flex: 3,
          child: Text(
            "SUMMIT TEAM",
            style: AppStyles.styleBold18(context).copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        Flexible(
          flex: 3,
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'بحث...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),

        Flexible(
          flex: 2,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AlessamyColors.primaryGold,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'اسم المستخدم',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'دور المستخدم',
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
