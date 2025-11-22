import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/Employees/presentation/widgets/role_distribution_card.dart';
import 'package:summit_team/features/dashboard/presentation/screens/tablet_dashboard_layout.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/custom_app_bar_sliever.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/dashboard_stats_card.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/detailed_income_chart.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'dr.dart' as property_stats;

class DesktopDashboardLayout extends StatefulWidget {
  const DesktopDashboardLayout({super.key});

  @override
  State<DesktopDashboardLayout> createState() => _DesktopDashboardLayoutState();
}

class _DesktopDashboardLayoutState extends State<DesktopDashboardLayout> {
  final List<PropertyModel> _properties = [];
  final int totalEmployees = 125;
  final int admins = 8;
  final int accountants = 22;
  final int employees = 95;
  final double growthRate = 12.5;
  final int newThisMonth = 15;

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

                  SliverToBoxAdapter(child: HederSiction()),

                  // Stats Cards - الصف الأول
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
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

                          const SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              color: AlessamyColors.cardBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SizedBox(
                                  width: 400,
                                  height: 400,
                                  child: IncomeSectionBody(),
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
                                  child: property_stats.PropertyStatsChart(
                                    propertyData: _propertyData,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Card(
                              color: AlessamyColors.cardBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: _buildEmployeesCards(
                                  context,
                                  totalEmployees,
                                  admins,
                                  accountants,
                                  employees,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              color: AlessamyColors.cardBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: RoleDistributionCard(
                                  totalEmployees: totalEmployees,
                                  admins: admins,
                                  accountants: accountants,
                                  employees: employees,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // SliverToBoxAdapter(
                  //   child: Expanded(
                  //     child:
                  //   ),
                  // ),
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
  Widget _buildEmployeesCards(
    BuildContext context,
    final int totalEmployees,
    final int admins,
    final int accountants,
    final int employees,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardStatsCard(
                  title: 'إجمالي الموظفين',
                  value: totalEmployees.toString(),
                  icon: Icons.people,
                  color: const Color(0xFF3498DB),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardStatsCard(
                  title: 'مدراء',
                  value: admins.toString(),
                  icon: Icons.admin_panel_settings,
                  color: const Color(0xFF9B59B6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DashboardStatsCard(
                  title: 'موظفين',
                  value: employees.toString(),
                  icon: Icons.person,
                  color: const Color(0xFF27AE60),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardStatsCard(
                  title: 'محاسبين',
                  value: accountants.toString(),
                  icon: Icons.account_balance,
                  color: const Color(0xFFF39C12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
