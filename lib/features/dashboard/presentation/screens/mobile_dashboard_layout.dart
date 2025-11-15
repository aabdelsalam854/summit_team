import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_team/config/routes/routes.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/dashboard_stats_card.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'package:summit_team/features/properties/presentation/widgets/property_card_widget.dart';

/// ---------------------------------------------------------------------------
/// 📱 MobileDashboardLayout — تخطيط الداشبورد للموبايل
/// ---------------------------------------------------------------------------
class MobileDashboardLayout extends StatefulWidget {
  const MobileDashboardLayout({super.key});

  @override
  State<MobileDashboardLayout> createState() => _MobileDashboardLayoutState();
}

class _MobileDashboardLayoutState extends State<MobileDashboardLayout> {
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
            fontSize: 18.sp,
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
        ],
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 16.h)),

            // Stats Cards
            SliverToBoxAdapter(child: _buildStatsCards(context)),

            SliverToBoxAdapter(child: SizedBox(height: 24.h)),

            // Properties Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'العقارات',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AlessamyColors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'عرض الكل',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AlessamyColors.primaryGold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),

            // Properties List
            _properties.isEmpty
                ? SliverToBoxAdapter(child: _buildEmptyState())
                : SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: PropertyCardWidget(
                            property: _properties[index],
                            onTap: () {
                              // TODO: Navigate to property details
                            },
                          ),
                        );
                      }, childCount: _properties.length),
                    ),
                  ),

            SliverToBoxAdapter(
              child: SizedBox(height: 80.h), // Space for FAB
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.kPropertyForm),
        backgroundColor: AlessamyColors.primaryGold,
        foregroundColor: AlessamyColors.black,
        child: const Icon(Icons.add),
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
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              gradient: AlessamyColors.goldToBlackGradient,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.dashboard,
              size: 32.sp,
              color: AlessamyColors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'لوحة التحكم',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AlessamyColors.white,
            ),
          ),
          SizedBox(height: 24.h),
          ListTile(
            leading: Icon(
              Icons.home,
              color: AlessamyColors.textLight,
              size: 22.sp,
            ),
            title: Text(
              'الرئيسية',
              style: TextStyle(
                color: AlessamyColors.textLight,
                fontSize: 14.sp,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.dashboard_customize,
              color: AlessamyColors.primaryGold,
              size: 22.sp,
            ),
            title: Text(
              'الداشبورد',
              style: TextStyle(
                color: AlessamyColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            selected: true,
            selectedTileColor: AlessamyColors.primaryGold.withValues(
              alpha: 0.1,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.real_estate_agent,
              color: AlessamyColors.textLight,
              size: 22.sp,
            ),
            title: Text(
              'العقارات',
              style: TextStyle(
                color: AlessamyColors.textLight,
                fontSize: 14.sp,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: AlessamyColors.textLight,
              size: 22.sp,
            ),
            title: Text(
              'الإعدادات',
              style: TextStyle(
                color: AlessamyColors.textLight,
                fontSize: 14.sp,
              ),
            ),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: AlessamyColors.textLight,
              size: 22.sp,
            ),
            title: Text(
              'تسجيل الخروج',
              style: TextStyle(
                color: AlessamyColors.textLight,
                fontSize: 14.sp,
              ),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardStatsCard(
                  title: 'إجمالي العقارات',
                  value: '${_properties.length}',
                  icon: Icons.home_work,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: DashboardStatsCard(
                  title: 'عقارات للبيع',
                  value:
                      '${_properties.where((p) => p.purpose == PropertyPurpose.sale).length}',
                  icon: Icons.sell,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: DashboardStatsCard(
                  title: 'عقارات للإيجار',
                  value:
                      '${_properties.where((p) => p.purpose == PropertyPurpose.rent).length}',
                  icon: Icons.key,
                  color: Colors.orange,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: DashboardStatsCard(
                  title: 'عقارات مميزة',
                  value: '${_properties.where((p) => p.isFeatured).length}',
                  icon: Icons.star,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          children: [
            Icon(
              Icons.home_work_outlined,
              size: 64.sp,
              color: AlessamyColors.textLight.withValues(alpha: 0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              'لا توجد عقارات بعد',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AlessamyColors.textLight,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'ابدأ بإضافة عقار جديد',
              style: TextStyle(
                fontSize: 13.sp,
                color: AlessamyColors.textLight.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
