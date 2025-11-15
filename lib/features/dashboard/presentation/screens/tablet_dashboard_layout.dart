import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_team/config/routes/routes.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/dashboard_stats_card.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/properties_table_widget.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';

/// ---------------------------------------------------------------------------
/// 📱 TabletDashboardLayout — تخطيط الداشبورد للتابلت
/// ---------------------------------------------------------------------------
class TabletDashboardLayout extends StatefulWidget {
  const TabletDashboardLayout({super.key});

  @override
  State<TabletDashboardLayout> createState() => _TabletDashboardLayoutState();
}

class _TabletDashboardLayoutState extends State<TabletDashboardLayout> {
  final List<PropertyModel> _properties = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlessamyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AlessamyColors.cardBackground,
        elevation: 0,
        title: Text(
          'لوحة التحكم',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AlessamyColors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              color: AlessamyColors.primaryGold,
            ),
          ),
          SizedBox(width: 8.w),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: AlessamyColors.primaryGold,
              child: Icon(
                Icons.person,
                color: AlessamyColors.black,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),

            // Stats Cards
            SliverToBoxAdapter(
              child: _buildStatsCards(context),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 32.h),
            ),

            // Properties Section
            SliverToBoxAdapter(
              child: _buildPropertiesSection(context),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 32.h),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.kPropertyForm),
        backgroundColor: AlessamyColors.primaryGold,
        foregroundColor: AlessamyColors.black,
        icon: const Icon(Icons.add),
        label: Text(
          'إضافة عقار',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AlessamyColors.cardBackground,
      child: Column(
        children: [
          SizedBox(height: 48.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: AlessamyColors.goldToBlackGradient,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.dashboard,
              size: 40.sp,
              color: AlessamyColors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'لوحة التحكم',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AlessamyColors.white,
            ),
          ),
          SizedBox(height: 32.h),
          ListTile(
            leading: Icon(Icons.home, color: AlessamyColors.textLight),
            title: Text(
              'الرئيسية',
              style: TextStyle(color: AlessamyColors.textLight),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.dashboard_customize, color: AlessamyColors.primaryGold),
            title: Text(
              'الداشبورد',
              style: TextStyle(color: AlessamyColors.white),
            ),
            selected: true,
            selectedTileColor: AlessamyColors.primaryGold.withValues(alpha: 0.1),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.real_estate_agent, color: AlessamyColors.textLight),
            title: Text(
              'العقارات',
              style: TextStyle(color: AlessamyColors.textLight),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: AlessamyColors.textLight),
            title: Text(
              'الإعدادات',
              style: TextStyle(color: AlessamyColors.textLight),
            ),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            leading: Icon(Icons.logout, color: AlessamyColors.textLight),
            title: Text(
              'تسجيل الخروج',
              style: TextStyle(color: AlessamyColors.textLight),
            ),
            onTap: () {},
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1.5,
        children: [
          DashboardStatsCard(
            title: 'إجمالي العقارات',
            value: '${_properties.length}',
            icon: Icons.home_work,
            color: Colors.blue,
          ),
          DashboardStatsCard(
            title: 'عقارات للبيع',
            value: '${_properties.where((p) => p.purpose == PropertyPurpose.sale).length}',
            icon: Icons.sell,
            color: Colors.green,
          ),
          DashboardStatsCard(
            title: 'عقارات للإيجار',
            value: '${_properties.where((p) => p.purpose == PropertyPurpose.rent).length}',
            icon: Icons.key,
            color: Colors.orange,
          ),
          DashboardStatsCard(
            title: 'عقارات مميزة',
            value: '${_properties.where((p) => p.isFeatured).length}',
            icon: Icons.star,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AlessamyColors.primaryGold.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'قائمة العقارات',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AlessamyColors.white,
            ),
          ),
          SizedBox(height: 20.h),
          PropertiesTableWidget(properties: _properties),
        ],
      ),
    );
  }
}
