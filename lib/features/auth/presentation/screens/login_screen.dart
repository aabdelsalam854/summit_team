import 'package:summit_team/core/adaptive_layout/adaptive_layout_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/desktop_login_layout.dart';
import 'package:summit_team/features/auth/presentation/widgets/mobile_login_layout.dart';
import 'package:summit_team/features/auth/presentation/widgets/tablet_login_layout.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: _buildMobileLayout,
      tabletLayout: _buildTabletLayout,
      desktopLayout: _buildDesktopLayout,
    );
  }

  static Widget _buildMobileLayout(BuildContext context) {
    return const MobileLoginLayout();
  }

  static Widget _buildTabletLayout(BuildContext context) {
    return const TabletLoginLayout();
  }

  static Widget _buildDesktopLayout(BuildContext context) {
    return const DesktopLoginLayout();
  }
}
