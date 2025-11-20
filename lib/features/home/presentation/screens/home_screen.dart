import 'package:flutter/material.dart';
import 'package:summit_team/core/adaptive_layout/adaptive_layout_widget.dart';
import 'package:summit_team/features/home/presentation/screens/desktop_home_layout.dart';
import 'package:summit_team/features/home/presentation/screens/mobile_home_layout.dart';
import 'package:summit_team/features/home/presentation/screens/tablet_home_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const MobileHomeLayout(),
      tabletLayout: (context) => const TabletHomeLayout(),
      desktopLayout: (context) => const DesktopHomeLayout(),
    );
  }
}