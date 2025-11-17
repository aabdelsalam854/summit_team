import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/Employees/presentation/pages/employees_layout.dart';

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
        backgroundColor: AlessamyColors.cardBackground,
        body: Row(
          children: [
            // ═══════════════════════════════════════
            // Custom Sidebar
            // ═══════════════════════════════════════
            // _buildSidebar(),

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
                    const EmployeesLayout()
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
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userName;
  final String userRole;
  final String? searchHint;
  final TextEditingController? searchController;
  final VoidCallback? onProfileTap;
  final ValueChanged<String>? onSearchChanged;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.userName,
    required this.userRole,
    this.searchHint = 'بحث...',
    this.searchController,
    this.onProfileTap,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AlessamyColors.primaryGold,
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
