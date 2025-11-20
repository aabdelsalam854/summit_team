import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:summit_team/config/routes/routes.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/widget/custom_text_button_with_icon.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/dashboard_stats_card.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/detailed_income_chart.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/properties_table_widget.dart';
import 'package:summit_team/features/home/presentation/screens/desktop_home_layout.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'dr.dart' as property_stats;

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
            fontSize: 20,
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
          SizedBox(width: 8),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AlessamyColors.primaryGold,
              child: Icon(Icons.person, color: AlessamyColors.black, size: 20),
            ),
          ),
        ],
      ),
      // drawer: _buildDrawer(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Stats Cards
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

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: _buildStatsCards(context),
              ),
            ),
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

                                // IncomeSectionBody(),
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
            // SliverToBoxAdapter(child: Expanded(child: _buildPropertiesSection(context))),
            // Properties Table (الكارت الخامس)
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(14),
            //     child: Card(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       color: AlessamyColors.cardBackground,
            //       child: Padding(
            //         padding: const EdgeInsets.all(16),
            //         child: SizedBox(
            //           height: 480, // مهم جداً لتحديد constraints
            //           child: Column(
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(
            //                     'العقارات المميزة',
            //                     style: TextStyle(
            //                       fontSize: 22,
            //                       fontWeight: FontWeight.bold,
            //                       color: AlessamyColors.white,
            //                     ),
            //                   ),
            //                   TextButton(
            //                     onPressed: () {},
            //                     child: Text(
            //                       'عرض المزيد',
            //                       style: TextStyle(
            //                         fontSize: 22,
            //                         fontWeight: FontWeight.bold,
            //                         color: AlessamyColors.primaryGold,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Expanded(
            //                 child: FeaturedPropertiesList(
            //                   scrollDirection: Axis.horizontal,
            //                   properties: getDemoProperties(),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Widget _buildDrawer(BuildContext context) {
  //   return Drawer(
  //     backgroundColor: AlessamyColors.cardBackground,
  //     child: Column(
  //       children: [
  //         SizedBox(height: 48),
  //         Container(
  //           padding: EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             gradient: AlessamyColors.goldToBlackGradient,
  //             shape: BoxShape.circle,
  //           ),
  //           child: Icon(Icons.dashboard, size: 40, color: AlessamyColors.white),
  //         ),
  //         SizedBox(height: 12),
  //         Text(
  //           'لوحة التحكم',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: AlessamyColors.white,
  //           ),
  //         ),
  //         SizedBox(height: 32),
  //         ListTile(
  //           leading: Icon(Icons.home, color: AlessamyColors.textLight),
  //           title: Text(
  //             'الرئيسية',
  //             style: TextStyle(color: AlessamyColors.textLight),
  //           ),
  //           onTap: () {},
  //         ),
  //         ListTile(
  //           leading: Icon(
  //             Icons.dashboard_customize,
  //             color: AlessamyColors.primaryGold,
  //           ),
  //           title: Text(
  //             'الداشبورد',
  //             style: TextStyle(color: AlessamyColors.white),
  //           ),
  //           selected: true,
  //           selectedTileColor: AlessamyColors.primaryGold.withValues(
  //             alpha: 0.1,
  //           ),
  //           onTap: () {},
  //         ),
  //         ListTile(
  //           leading: Icon(
  //             Icons.real_estate_agent,
  //             color: AlessamyColors.textLight,
  //           ),
  //           title: Text(
  //             'العقارات',
  //             style: TextStyle(color: AlessamyColors.textLight),
  //           ),
  //           onTap: () {},
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.settings, color: AlessamyColors.textLight),
  //           title: Text(
  //             'الإعدادات',
  //             style: TextStyle(color: AlessamyColors.textLight),
  //           ),
  //           onTap: () {},
  //         ),
  //         const Spacer(),
  //         ListTile(
  //           leading: Icon(Icons.logout, color: AlessamyColors.textLight),
  //           title: Text(
  //             'تسجيل الخروج',
  //             style: TextStyle(color: AlessamyColors.textLight),
  //           ),
  //           onTap: () {},
  //         ),
  //         SizedBox(height: 24),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStatsCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: DashboardStatsCard(
              title: 'إجمالي العقارات',
              value: '${_properties.length}',
              icon: Icons.home_work,
              color: Colors.blue,
            ),
          ),

          SizedBox(width: 16),

          Expanded(
            child: DashboardStatsCard(
              title: 'عقارات للبيع',
              value:
                  '${_properties.where((p) => p.purpose == PropertyPurpose.sale).length}',
              icon: Icons.sell,
              color: Colors.green,
            ),
          ),

          SizedBox(width: 16),

          Expanded(
            child: DashboardStatsCard(
              title: 'عقارات للإيجار',
              value:
                  '${_properties.where((p) => p.purpose == PropertyPurpose.rent).length}',
              icon: Icons.key,
              color: Colors.orange,
            ),
          ),

          SizedBox(width: 16),

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
    );
  }

  Widget _buildPropertiesSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AlessamyColors.white,
            ),
          ),
          SizedBox(height: 20),
          PropertiesTableWidget(properties: getDemoProperties()),
        ],
      ),
    );
  }
}
