import 'package:flutter/material.dart';
import 'package:summit_team/core/adaptive_layout/adaptive_layout_widget.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/dashboard/presentation/screens/desktop_dashboard_layout.dart';
import 'package:summit_team/features/dashboard/presentation/screens/mobile_dashboard_layout.dart';
import 'package:summit_team/features/dashboard/presentation/screens/tablet_dashboard_layout.dart';

// /// ---------------------------------------------------------------------------
// / 🎛️ DashboardScreen — الشاشة الرئيسية للداشبورد
// / ---------------------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: AlessamyColors.backgroundColor,
      body: const AdaptiveLayout(
        mobileLayout: _buildMobileLayout,
        tabletLayout: _buildTabletLayout,
        desktopLayout: _buildDesktopLayout,
      ),
    );
  }

  static Widget _buildMobileLayout(BuildContext context) {
    return const MobileDashboardLayout();
  }

  static Widget _buildTabletLayout(BuildContext context) {
    return const TabletDashboardLayout();
  }

  /// / Desktop Layout for the DashboardScreen
  ///
  static Widget _buildDesktopLayout(BuildContext context) {
    return const DesktopDashboardLayout();
  }
}
