import 'package:flutter/material.dart';
import 'package:summit_team/core/adaptive_layout/adaptive_layout_widget.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _visitedPages.add(index);
    });

    // اقفل الـ Drawer لو كان مفتوح (للموبايل)
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
          backgroundColor: AlessamyColors.cardBackground,
          drawer: Drawer(
            child: CustomDrawer(
              onPageSelected: _onItemTapped,
              selectedIndex: _selectedIndex,
            ),
          ),
          body: Column(
            children: [
              _buildMobileAppBar(),
              Expanded(child: _buildContent()),
            ],
          ),
        ),

        // ════════════════════════════════════════
        // 📱 Tablet Layout - Sidebar مصغر (Icons فقط)
        // ════════════════════════════════════════
        tabletLayout: (context) => Scaffold(
          backgroundColor: AlessamyColors.cardBackground,
          body: Row(
            children: [
              // Sidebar مصغر - عرض 70
              SizedBox(
                width: 70,
                child: CustomDrawer(
                  onPageSelected: _onItemTapped,
                  selectedIndex: _selectedIndex,
                  isCompact: true,
                ),
              ),
              // Content
              Expanded(child: _buildContent()),
            ],
          ),
        ),

        // ════════════════════════════════════════
        // 🖥️ Desktop Layout - Sidebar كامل
        // ════════════════════════════════════════
        desktopLayout: (context) => Scaffold(
          backgroundColor: AlessamyColors.cardBackground,
          body: Row(
            children: [
              // Sidebar كامل - عرض 250
              SizedBox(
                width: 250,
                child: CustomDrawer(
                  onPageSelected: _onItemTapped,
                  selectedIndex: _selectedIndex,
                ),
              ),
              // Content
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════
  // Content Area مع Lazy Loading
  // ════════════════════════════════════════
  Widget _buildContent() {
    return IndexedStack(
      index: _selectedIndex,
      children: [
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
    );
  }

  // ════════════════════════════════════════
  // Mobile AppBar مع Hamburger Menu
  // ════════════════════════════════════════
  Widget _buildMobileAppBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AlessamyColors.primaryGold,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
            const Expanded(
              child: Text(
                'Summit Team',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Avatar للموبايل
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
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

// class CustomDrawer extends StatelessWidget {
//   final Function(int) onPageSelected;
//   final int selectedIndex;
//   final bool isCompact;

//   const CustomDrawer({
//     super.key,
//     required this.onPageSelected,
//     required this.selectedIndex,
//     this.isCompact = false, // Default = Full Sidebar
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             AlessamyColors.primaryGold,
//             AlessamyColors.primaryGold.withOpacity(0.8),
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(2, 0),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // ════════════════════════════════════════
//           // Header
//           // ════════════════════════════════════════
//           _buildHeader(),

//           const Divider(color: Colors.white24, height: 1),
//           const SizedBox(height: 20),

//           // ════════════════════════════════════════
//           // Menu Items
//           // ════════════════════════════════════════
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               children: [
//                 _buildMenuItem(
//                   index: 0,
//                   icon: Icons.home_rounded,
//                   title: 'الرئيسية',
//                 ),
//                 _buildMenuItem(
//                   index: 1,
//                   icon: Icons.dashboard_rounded,
//                   title: 'لوحة التحكم',
//                 ),
//                 _buildMenuItem(
//                   index: 2,
//                   icon: Icons.people_rounded,
//                   title: 'الموظفين',
//                 ),
//                 _buildMenuItem(
//                   index: 3,
//                   icon: Icons.settings_rounded,
//                   title: 'الإعدادات',
//                 ),
//               ],
//             ),
//           ),

//           // ════════════════════════════════════════
//           // Footer
//           // ════════════════════════════════════════
//           if (!isCompact) _buildFooter(),
//         ],
//       ),
//     );
//   }

//   // ════════════════════════════════════════
//   // Header Widget
//   // ════════════════════════════════════════
//   Widget _buildHeader() {
//     return Container(
//       height: isCompact ? 80 : 120,
//       padding: EdgeInsets.all(isCompact ? 12 : 20),
//       child: Center(
//         child: isCompact
//             ? const Icon(Icons.business_rounded, color: Colors.white, size: 36)
//             : const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.business_rounded, color: Colors.white, size: 48),
//                   SizedBox(height: 8),
//                   Text(
//                     'Summit Team',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }

//   // ════════════════════════════════════════
//   // Menu Item Widget
//   // ════════════════════════════════════════
//   Widget _buildMenuItem({
//     required int index,
//     required IconData icon,
//     required String title,
//   }) {
//     final isSelected = selectedIndex == index;

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => onPageSelected(index),
//           borderRadius: BorderRadius.circular(12),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             padding: EdgeInsets.symmetric(
//               horizontal: isCompact ? 0 : 16,
//               vertical: 14,
//             ),
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? Colors.white.withOpacity(0.2)
//                   : Colors.transparent,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: isSelected
//                     ? Colors.white.withOpacity(0.3)
//                     : Colors.transparent,
//                 width: 1,
//               ),
//             ),
//             child: isCompact
//                 ? Center(child: Icon(icon, color: Colors.white, size: 26))
//                 : Row(
//                     children: [
//                       Icon(icon, color: Colors.white, size: 24),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Text(
//                           title,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: isSelected
//                                 ? FontWeight.bold
//                                 : FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       if (isSelected)
//                         Container(
//                           width: 6,
//                           height: 6,
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ════════════════════════════════════════
//   // Footer Widget
//   // ════════════════════════════════════════
//   Widget _buildFooter() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: const Column(
//         children: [
//           Divider(color: Colors.white24, height: 1),
//           SizedBox(height: 12),
//           Text(
//             'Version 1.0.0',
//             style: TextStyle(color: Colors.white70, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }
