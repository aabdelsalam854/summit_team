import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_team/config/routes/routes.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/widget/custom_text_button_with_icon.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/custom_app_bar_sliever.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/dashboard_stats_card.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/detailed_income_chart.dart';

import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'dr.dart' as property_stats;

/// ---------------------------------------------------------------------------
/// 🖥️ DesktopDashboardLayout — تخطيط الداشبورد للديسكتوب
/// ---------------------------------------------------------------------------
class DesktopDashboardLayout extends StatefulWidget {
  const DesktopDashboardLayout({super.key});

  @override
  State<DesktopDashboardLayout> createState() => _DesktopDashboardLayoutState();
}

class _DesktopDashboardLayoutState extends State<DesktopDashboardLayout> {
  final List<PropertyModel> _properties = [];

  // بيانات إحصائيات العقارات
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
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: CustomScrollView(
                slivers: [
                  // Header
                  CustomAppBarSliever(),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'مرحباً بك في لوحة التحكم',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AlessamyColors.white,
                            ),
                          ),
                          Row(
                            children: [
                              CustomButtonWithIcon(
                                textColor: Colors.white,
                                height: 60,
                                width: 180,
                                text: "Export Excel",
                                onPressed: () {},
                                icon: Icons.table_chart_rounded,
                                buttonType: ButtonType.outlined,
                                arrowIconLeft: true,
                                arrowIconRight: false,
                              ),
                              SizedBox(width: 16),
                              CustomButtonWithIcon(
                                textColor: Colors.white,
                                height: 60,
                                width: 180,
                                text: "إضافة عقار جديد",
                                onPressed: () {
                                  context.push(Routes.kPropertyForm);
                                },
                                icon: Icons.arrow_circle_down_rounded,
                                buttonType: ButtonType.outlined,
                                arrowIconLeft: true,
                                arrowIconRight: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Stats Cards - الصف الأول
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          // Stats Cards (الكارت الأول)
                          Expanded(
                            child: Card(
                              color: AlessamyColors.cardBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SizedBox(
                                  height: 480,
                                  child: _buildStatsCards(context),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Property Stats Chart (الكارت الثاني)
                          Expanded(
                            child: Card(
                              color: AlessamyColors.cardBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SizedBox(
                                  height: 480,
                                  child: property_stats.PropertyStatsChart(
                                    propertyData: _propertyData,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Income Chart & Featured Properties - الصف الثاني
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          // Income Chart (الكارت الثالث)
                          Expanded(
                            child: Card(
                              color: AlessamyColors.cardBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SizedBox(
                                  height: 480,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 400,
                                        child: DetailedIncomeChart(),
                                      ),
                                      const SizedBox(height: 16),
                                      IncomeLegend(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Featured Properties (الكارت الرابع)
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: AlessamyColors.cardBackground,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SizedBox(
                                  height: 480,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AlessamyColors.primaryGold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Expanded(
                                      //   child: FeaturedPropertiesList(
                                      //     properties: _getDemoProperties(),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header

  /// Stats Cards
  Widget _buildStatsCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
              const SizedBox(width: 16),
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
          const SizedBox(height: 16),
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
              const SizedBox(width: 16),
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

  /// Show Add Property Dialog
  // void _showAddPropertyDialog(BuildContext context) {
  //   context.push(Routes.kPropertyForm);
  // }
}
