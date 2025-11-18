import 'package:flutter/material.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onPageSelected;
  final bool isCompact; // ⬅️ للـ Tablet Mode

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onPageSelected,
    this.isCompact = false, // Default = Full Size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCompact ? 70 : 250, // ⬅️ عرض ديناميكي
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
          // Logo (يختفي في Compact Mode)
          if (!isCompact)
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

          // Logo صغير للـ Compact Mode
          if (isCompact)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Icon(
                  Icons.business_rounded,
                  color: AlessamyColors.primaryGold,
                  size: 36,
                ),
              ),
            ),

          // Divider بعد اللوجو
          SliverToBoxAdapter(
            child: Divider(
              color: AlessamyColors.primaryGold.withOpacity(0.1),
              thickness: 1,
              indent: isCompact ? 8 : 16,
              endIndent: isCompact ? 8 : 16,
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
              isCompact: isCompact, // ⬅️ تمرير الحالة
            ),
          ),
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.dashboard_customize,
              title: 'الداشبورد',
              isSelected: selectedIndex == 1,
              onTap: () => onPageSelected(1),
              isCompact: isCompact,
            ),
          ),
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.people,
              title: 'الموظفين',
              isSelected: selectedIndex == 2,
              onTap: () => onPageSelected(2),
              isCompact: isCompact,
            ),
          ),
          SliverToBoxAdapter(
            child: MenuItem(
              icon: Icons.settings,
              title: 'الإعدادات',
              isSelected: selectedIndex == 3,
              onTap: () => onPageSelected(3),
              isCompact: isCompact,
            ),
          ),

          // الجزء السفلي: Logout
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
                  isCompact: isCompact,
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

// ════════════════════════════════════════════════════════════
// MenuItem (معدّل للـ Compact Mode)
// ════════════════════════════════════════════════════════════
class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.isCompact = false, // ⬅️ جديد
  });

  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isCompact; // ⬅️ جديد

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 8 : 12,
        vertical: 4,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 0 : 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              gradient: isSelected ? AlessamyColors.goldToBlackGradient : null,
              color: isSelected ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AlessamyColors.primaryGold.withOpacity(0.3)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: isCompact
                ? Center(
                    // ⬅️ Compact Mode - Icon فقط
                    child: Icon(
                      icon,
                      size: 24,
                      color: isSelected
                          ? AlessamyColors.white
                          : AlessamyColors.textLight,
                    ),
                  )
                : Row(
                    // ⬅️ Full Mode - Icon + Text
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
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
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