import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:summit_team/config/routes/routes.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/widget/custom_text_button_with_icon.dart';

import 'package:summit_team/features/dashboard/presentation/widgets/dashboard_stats_card.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/detailed_income_chart.dart';
import 'package:summit_team/features/home/presentation/screens/desktop_home_layout.dart';
import 'package:summit_team/features/home/presentation/screens/mobile_home_layout.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';

import 'dr.dart' as property_stats;

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
  final Map<property_stats.PropertyType, property_stats.PropertyStats>
  _propertyData = {
    property_stats.PropertyType.villa: property_stats.PropertyStats(
      available: 15,
      rented: 8,
      sold: 3,
    ),
    property_stats.PropertyType.apartment: property_stats.PropertyStats(
      available: 25,
      rented: 18,
      sold: 7,
    ),
    property_stats.PropertyType.shop: property_stats.PropertyStats(
      available: 10,
      rented: 6,
      sold: 2,
    ),
    property_stats.PropertyType.land: property_stats.PropertyStats(
      available: 12,
      rented: 4,
      sold: 5,
    ),
  };
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
            fontSize: 18,
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
            // Greeting & Buttons
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرحباً بك في لوحة التحكم',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AlessamyColors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtonWithIcon(
                            arrowIconRight: true,
                            textColor: Colors.white,
                            height: 60,
                            text: "Export Excel",
                            onPressed: () {},
                            icon: Icons.table_chart_rounded,
                            buttonType: ButtonType.outlined,
                            arrowIconLeft: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButtonWithIcon(
                            arrowIconRight: true,
                            textColor: Colors.white,
                            height: 60,
                            text: "إضافة عقار جديد",
                            onPressed: () => context.push(Routes.kPropertyForm),
                            icon: Icons.arrow_circle_down_rounded,
                            buttonType: ButtonType.outlined,
                            arrowIconLeft: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Stats Cards
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Card(
                  color: AlessamyColors.cardBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildStatsCards(context),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Property Stats Chart
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Card(
                  color: AlessamyColors.cardBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: property_stats.PropertyStatsChart(
                      propertyData: _propertyData,
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Income Chart
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Card(
                  color: AlessamyColors.cardBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: 100, // الارتفاع اللي انت عايزه
                        //   width: double.infinity, // يمين وشمال
                        //   child: DetailedIncomeChart(),
                        // ),
                        const SizedBox(height: 16),
                        IncomeSectionBody(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Featured Properties
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Card(
                  color: AlessamyColors.cardBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'العقارات المميزة',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AlessamyColors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'عرض المزيد',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AlessamyColors.primaryGold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        FeaturedPropertiesList(
                          scrollDirection: Axis.horizontal,

                          properties: getDemoProperties(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
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
          SizedBox(height: 48),
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: AlessamyColors.goldToBlackGradient,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.dashboard, size: 32, color: AlessamyColors.white),
          ),
          SizedBox(height: 12),
          Text(
            'لوحة التحكم',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AlessamyColors.white,
            ),
          ),
          SizedBox(height: 24),
          ListTile(
            leading: Icon(
              Icons.home,
              color: AlessamyColors.textLight,
              size: 22,
            ),
            title: Text(
              'الرئيسية',
              style: TextStyle(color: AlessamyColors.textLight, fontSize: 14),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.dashboard_customize,
              color: AlessamyColors.primaryGold,
              size: 22,
            ),
            title: Text(
              'الداشبورد',
              style: TextStyle(
                color: AlessamyColors.white,
                fontSize: 14,
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
              size: 22,
            ),
            title: Text(
              'العقارات',
              style: TextStyle(color: AlessamyColors.textLight, fontSize: 14),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: AlessamyColors.textLight,
              size: 22,
            ),
            title: Text(
              'الإعدادات',
              style: TextStyle(color: AlessamyColors.textLight, fontSize: 14),
            ),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: AlessamyColors.textLight,
              size: 22,
            ),
            title: Text(
              'تسجيل الخروج',
              style: TextStyle(color: AlessamyColors.textLight, fontSize: 14),
            ),
            onTap: () {},
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
              SizedBox(width: 12),
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
          SizedBox(height: 12),
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
              SizedBox(width: 12),
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
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.home_work_outlined,
              size: 64,
              color: AlessamyColors.textLight.withValues(alpha: 0.5),
            ),
            SizedBox(height: 16),
            Text(
              'لا توجد عقارات بعد',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AlessamyColors.textLight,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'ابدأ بإضافة عقار جديد',
              style: TextStyle(
                fontSize: 13,
                color: AlessamyColors.textLight.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
