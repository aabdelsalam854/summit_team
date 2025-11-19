import 'package:summit_team/features/home/presentation/screens/desktop_home_layout.dart';
import 'package:summit_team/features/home/presentation/screens/mobile_home_layout.dart';
import 'package:summit_team/features/home/presentation/screens/tablet_home_layout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 800) {
      return const MobileHomeLayout();
    } else if (width < 1200) {
      return const TabletHomeLayout();
    } else {
      return const DesktopHomeLayout();
    }
  }
}