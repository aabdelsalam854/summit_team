import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_team/config/routes/routes.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onPageSelected;

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        border: Border(
          left: BorderSide(
            color: AlessamyColors.primaryGold.withOpacity(0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
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

          // Divider بعد اللوجو
          SliverToBoxAdapter(
            child: Divider(
              color: AlessamyColors.primaryGold.withOpacity(0.1),
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // Menu Items
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.home,
              title: 'الرئيسية',
              isSelected: selectedIndex == 0,
              onTap: () => onPageSelected(0),
            ),
          ),
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.dashboard_customize,
              title: 'الداشبورد',
              isSelected: selectedIndex == 1,
              onTap: () => onPageSelected(1),
            ),
          ),
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.people,
              title: 'الموظفين',
              isSelected: selectedIndex == 2,
              onTap: () => onPageSelected(2),
            ),
          ),
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.settings,
              title: 'الإعدادات',
              isSelected: selectedIndex == 3,
              onTap: () => onPageSelected(3),
            ),
          ),

          // الجزء السفلي: User Info + Logout
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                
            
                
                const SizedBox(height: 12),
                
                // Logout
                MenuItem(
                  icon: Icons.logout,
                  title: 'تسجيل الخروج',
                  isSelected: false,
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AlessamyColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'تأكيد تسجيل الخروج',
            style: TextStyle(
              color: AlessamyColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'هل أنت متأكد من تسجيل الخروج؟',
            style: TextStyle(color: AlessamyColors.textLight),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إلغاء',
                style: TextStyle(color: AlessamyColors.textLight),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: تسجيل الخروج
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AlessamyColors.primaryGold,
                // foregroundColor: AlessamyColors.,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('تسجيل الخروج'),
            ),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: isSelected ? AlessamyColors.goldToBlackGradient : null,
              color: isSelected ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
                    ? AlessamyColors.primaryGold.withOpacity(0.3)
                    : Colors.transparent,
                width: 1,
              ),
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
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected
                          ? AlessamyColors.white
                          : AlessamyColors.textLight,
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AlessamyColors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}