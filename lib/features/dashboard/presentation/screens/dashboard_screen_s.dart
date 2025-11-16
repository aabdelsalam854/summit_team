import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/Employees/presentation/models/employee.dart';
import 'package:summit_team/features/Employees/presentation/pages/employees_screen.dart';
import 'package:summit_team/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/custom_drower.dart';
import 'package:summit_team/features/home/presentation/screens/home_screen.dart';

// ════════════════════════════════════════════════════════════
// Dashboard احترافي بدون أي باكدج خارجي - Pure Flutter ⚡
// ════════════════════════════════════════════════════════════

class PureFlutterDashboard extends StatefulWidget {
  const PureFlutterDashboard({super.key});

  @override
  State<PureFlutterDashboard> createState() => _PureFlutterDashboardState();
}

class _PureFlutterDashboardState extends State<PureFlutterDashboard> {
  int _selectedIndex = 0;
  final Set<int> _visitedPages = {0};

  // قائمة الصفحات
  static const List<_MenuItem> _menuItems = [
    _MenuItem(icon: Icons.home, label: 'الرئيسية'),
    _MenuItem(icon: Icons.dashboard_customize, label: 'لوحة التحكم'),
    _MenuItem(icon: Icons.people, label: 'الموظفين'),
    _MenuItem(icon: Icons.settings, label: 'الإعدادات'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _visitedPages.add(index); // للـ Lazy Loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // appBar:CustomAppBar(title: "title", userName: "userName", userRole: "userRole") ,
        backgroundColor: AlessamyColors.cardBackground,
        body: Row(
          children: [
            // ═══════════════════════════════════════
            // Custom Sidebar (بدون باكدج)
            // ═══════════════════════════════════════
            _buildSidebar(),

            // ═══════════════════════════════════════
            // Content Area
            // ═══════════════════════════════════════
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  // Lazy Loading - بيحمل الصفحة لما تفتحها بس
                  if (_visitedPages.contains(0))
                    const HomeScreen()
                  else
                    const SizedBox.shrink(),

                  if (_visitedPages.contains(1))
                    const DashboardScreen()
                  else
                    const SizedBox.shrink(),

                  if (_visitedPages.contains(2))
                    const ProfessionalEmployeesDashboard()
                  else
                    const SizedBox.shrink(),

                  if (_visitedPages.contains(3))
                    const DashboardScreen()
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return CustomDrawer(
      onPageSelected: _onItemTapped,

      selectedIndex: _selectedIndex,
    );

    //  Container(
    //   width: 250,
    //   decoration: BoxDecoration(
    //     color:  AlessamyColors.cardBackground,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.3),
    //         blurRadius: 10,
    //         offset: const Offset(2, 0),
    //       ),
    //     ],
    //   ),
    //   child: CustomScrollView(
    //     slivers: [
    //       // Header
    //       SliverToBoxAdapter(child: _buildSidebarHeader()),

    //       const SliverToBoxAdapter(child:  SizedBox(height: 20)),

    //       // // Menu Items
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: _menuItems.length,
    //           padding: const EdgeInsets.symmetric(horizontal: 12),
    //           itemBuilder: (context, index) {
    //             return _buildMenuItem(index);
    //           },
    //         ),
    //       ),

    //       // Footer
    //       _buildSidebarFooter(),
    //     ],
    //   ),
    // );
  }

  Widget _buildSidebarHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1419),
          border: Border(
            bottom: BorderSide(color: Colors.grey[800]!, width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1C40F).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.business,
                color: Color(0xFFF1C40F),
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نظام الإدارة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Dashboard Pro',
                  style: TextStyle(color: Color(0xFF95A5A6), fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(int index) {
    final item = _menuItems[index];
    final isSelected = _selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onItemTapped(index),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFF1C40F).withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFF1C40F).withOpacity(0.4)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: isSelected
                      ? const Color(0xFFF1C40F)
                      : const Color(0xFF95A5A6),
                  size: 22,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF95A5A6),
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1C40F),
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

  Widget _buildSidebarFooter() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1419),
          border: Border(top: BorderSide(color: Colors.grey[800]!, width: 1)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF1C40F).withOpacity(0.2),
              child: const Text(
                'أ',
                style: TextStyle(
                  color: Color(0xFFF1C40F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'أحمد محمد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'مدير النظام',
                    style: TextStyle(color: Color(0xFF95A5A6), fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              color: const Color(0xFF95A5A6),
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Menu Item Model
// ════════════════════════════════════════════════════════════

class _MenuItem {
  final IconData icon;
  final String label;

  const _MenuItem({required this.icon, required this.label});
}

// ════════════════════════════════════════════════════════════
// الصفحات
// ════════════════════════════════════════════════════════════

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userName;
  final String userRole;
  final String? searchHint;
  final TextEditingController? searchController;
  final VoidCallback? onProfileTap;
  final ValueChanged<String>? onSearchChanged;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.userName,
    required this.userRole,
    this.searchHint = 'بحث...',
    this.searchController,
    this.onProfileTap,
    this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AlessamyColors.primaryGold, // أو اللون المناسب
      elevation: 0,
      toolbarHeight: 80,
      title: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: searchHint,
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
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AlessamyColors.primaryGold,
                  child: IconButton(
                    onPressed: onProfileTap,
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          userRole,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
