import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';

class CustomDrower extends StatelessWidget {
  const CustomDrower({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        border: Border(
          right: BorderSide(
            color: AlessamyColors.primaryGold.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          // Logo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Image.asset(
                'assets/images/logo.png',
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Menu Items
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.home,
              title: 'الرئيسية',
              isSelected: false,
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.dashboard_customize,
              title: 'الداشبورد',
              isSelected: true,
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.person,
              title: 'الموظفين',
              isSelected: false,
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.settings,
              title: 'الإعدادات',
              isSelected: false,
              onTap: () {},
            ),
          ),

          // الجزء السفلي: Logout
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                MenuItem(
                  icon: Icons.logout,
                  title: 'تسجيل الخروج',
                  isSelected: false,
                  onTap: () {},
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          gradient: isSelected ? AlessamyColors.goldToBlackGradient : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected
                  ? AlessamyColors.white
                  : AlessamyColors.textLight,
            ),
            SizedBox(width: 14),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? AlessamyColors.white
                    : AlessamyColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
