import 'package:flutter/material.dart';
import 'package:summit_team/core/adaptive_layout/adaptive_layout_widget.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/Employees/presentation/pages/employees_layout.dart';

import 'package:summit_team/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/custom_app_bar.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/custom_drower.dart';
import 'package:summit_team/features/home/presentation/screens/home_screen.dart';

class PureFlutterDashboard extends StatefulWidget {
  const PureFlutterDashboard({super.key});

  @override
  State<PureFlutterDashboard> createState() => _PureFlutterDashboardState();
}

class _PureFlutterDashboardState extends State<PureFlutterDashboard> {
  int _selectedIndex = 0;
  final Set<int> _visitedPages = {0};
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
        Navigator.of(context).pop();
      }
      return;
    }

    setState(() {
      _selectedIndex = index;
      _visitedPages.add(index);
    });

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AdaptiveLayout(
        // ════════════════════════════════════════
        // 📱 Mobile Layout - Drawer منزلق
        // ════════════════════════════════════════
        mobileLayout: (context) => Scaffold(
          key: _scaffoldKey,
          // backgroundColor: AlessamyColors.cardBackground,
          drawer: Drawer(
            child: RepaintBoundary(
              child: CustomDrawer(
                onPageSelected: _onItemTapped,
                selectedIndex: _selectedIndex,
              ),
            ),
          ),
          body: Column(
            children: [
              RepaintBoundary(
                child: CustomAppBar(
                  title: "Dashboard",
                  userName: "userName",
                  userRole: "userRole",
                ),
              ),
              Expanded(child: RepaintBoundary(child: _buildContent())),
            ],
          ),
        ),

        // ════════════════════════════════════════
        // 📱 Tablet Layout - Sidebar مصغر (Icons فقط)
        // ════════════════════════════════════════
        tabletLayout: (context) => Scaffold(
          // backgroundColor: AlessamyColors.cardBackground,
          body: Row(
            children: [
              // Sidebar مصغر - عرض 70
              RepaintBoundary(
                child: SizedBox(
                  width: 70,
                  child: CustomDrawer(
                    onPageSelected: _onItemTapped,
                    selectedIndex: _selectedIndex,
                    isCompact: true,
                  ),
                ),
              ),
              // Content
              Expanded(child: RepaintBoundary(child: _buildContent())),
            ],
          ),
        ),

        // ════════════════════════════════════════
        // 🖥️ Desktop Layout - Sidebar كامل
        // ════════════════════════════════════════
        desktopLayout: (context) => Scaffold(
          // backgroundColor: AlessamyColors.cardBackground,
          body: Row(
            children: [
              // Sidebar كامل - عرض 250
              RepaintBoundary(
                child: SizedBox(
                  width: 250,
                  child: CustomDrawer(
                    onPageSelected: _onItemTapped,
                    selectedIndex: _selectedIndex,
                  ),
                ),
              ),
              // Content
              Expanded(child: RepaintBoundary(child: _buildContent())),
            ],
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════
  // Content Area مع Lazy Loading و Optimized Performance
  // ════════════════════════════════════════
  Widget _buildContent() {
    return IndexedStack(
      index: _selectedIndex,
      sizing: StackFit.expand, // تحسين الأداء
      children: [
        // Page 0: Home
        _visitedPages.contains(0)
            ? const HomeScreen(key: ValueKey('home_screen'))
            : const SizedBox.shrink(key: ValueKey('home_empty')),

        // Page 1: Dashboard
        _visitedPages.contains(1)
            ? const DashboardScreen(key: ValueKey('dashboard_screen'))
            : const SizedBox.shrink(key: ValueKey('dashboard_empty')),

        // Page 2: Employees
        _visitedPages.contains(2)
            ? const EmployeesLayout(key: ValueKey('employees_screen'))
            : const SizedBox.shrink(key: ValueKey('employees_empty')),

        // Page 3: Settings
        _visitedPages.contains(3)
            ? const DashboardScreen(key: ValueKey('settings_screen'))
            : const SizedBox.shrink(key: ValueKey('settings_empty')),
      ],
    );
  }

  // ════════════════════════════════════════
  // Mobile AppBar مع Hamburger Menu
  // ════════════════════════════════════════
  // Widget _buildMobileAppBar() {
  //   return Container(
  //     height: 60,
  //     decoration: BoxDecoration(
  //       color: AlessamyColors.primaryGold,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           blurRadius: 4,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 8),
  //       child: Row(
  //         children: [
  //           IconButton(
  //             icon: const Icon(Icons.menu, color: Colors.white, size: 28),
  //             onPressed: () {
  //               _scaffoldKey.currentState?.openDrawer();
  //             },
  //           ),
  //           const Expanded(
  //             child: Text(
  //               'Summit Team',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //           // Avatar للموبايل
  //           CircleAvatar(
  //             radius: 18,
  //             backgroundColor: Colors.white.withOpacity(0.2),
  //             child: const Icon(Icons.person, color: Colors.white, size: 20),
  //           ),
  //           const SizedBox(width: 8),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
