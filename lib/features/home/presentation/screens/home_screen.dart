import 'package:summit_team/core/adaptive_layout/adaptive_layout_widget.dart';
import 'package:summit_team/features/home/presentation/screens/desktop_home_layout.dart';
import 'package:summit_team/features/home/presentation/screens/mobile_home_layout.dart';
import 'package:summit_team/features/home/presentation/screens/tablet_home_layout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdaptiveLayout(
      mobileLayout: _buildMobileLayout,
      tabletLayout: _buildTabletLayout,
      desktopLayout: _buildDesktopLayout,
    );
  }

  static Widget _buildMobileLayout(BuildContext context) {
    return const MobileHomeLayout();
  }

  static Widget _buildTabletLayout(BuildContext context) {
    return const TabletHomeLayout();
  }

  static Widget _buildDesktopLayout(BuildContext context) {
    return const DesktopHomeLayout();
  }
}
