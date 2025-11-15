import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/home/presentation/widgets/custom_app_bar_widget.dart';
import 'package:summit_team/features/home/presentation/widgets/hero_section_widget.dart';
import 'package:summit_team/features/home/presentation/widgets/search_filter_widget.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'package:summit_team/features/properties/presentation/widgets/property_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:summit_team/config/locale/app_localizations.dart';
import 'package:summit_team/config/locale/keys_translate.dart';

/// Desktop Layout للصفحة الرئيسية
class DesktopHomeLayout extends StatelessWidget {
  const DesktopHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AlessamyColors.backgroundColor,
      appBar: const CustomAppBarWidget(),
      endDrawer: const CustomDrawerWidget(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Hero Section
            const SliverToBoxAdapter(
              child: HeroSectionWidget(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 40.h),
            ),

            // Search Filter + Quick Stats
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SearchFilterWidget(
                        onSearch: (filter) {
                          debugPrint('Desktop Search: $filter');
                        },
                      ),
                    ),
                    SizedBox(width: 28.w),
                    Expanded(flex: 2, child: _buildQuickStats(context)),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 48.h),
            ),

            // العقارات المميزة - Header
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                context,
                title: l10n.translate(KeysTranslate.sectionFeatured),
                subtitle: l10n.translate(KeysTranslate.sectionFeaturedSubtitle),
                onViewAll: () {},
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),

            // العقارات المميزة - القائمة
            SliverToBoxAdapter(
              child: _buildFeaturedProperties(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 48.h),
            ),

            // أحدث العروض - Header
            SliverToBoxAdapter(
              child: _buildSectionHeader(
                context,
                title: l10n.translate(KeysTranslate.sectionLatest),
                subtitle: l10n.translate(KeysTranslate.sectionLatestSubtitle),
                onViewAll: () {},
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),

            // أحدث العروض - Grid
            SliverToBoxAdapter(
              child: _buildLatestPropertiesSliver(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 48.h),
            ),

            // Stats Section
            SliverToBoxAdapter(
              child: _buildStatsSection(context),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 48.h),
            ),

            // Footer
            SliverToBoxAdapter(
              child: _buildFooter(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        gradient: AlessamyColors.goldToBlackGradient,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AlessamyColors.primaryGold.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.translate(KeysTranslate.quickStatsTitle),
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AlessamyColors.white,
            ),
          ),
          SizedBox(height: 24.h),
          _buildQuickStatItem(
            Icons.home_work,
            '500+',
            l10n.translate(KeysTranslate.statsProperties),
          ),
          SizedBox(height: 16.h),
          _buildQuickStatItem(
            Icons.people,
            '1000+',
            l10n.translate(KeysTranslate.statsClients),
          ),
          SizedBox(height: 16.h),
          _buildQuickStatItem(
            Icons.location_city,
            '50+',
            l10n.translate(KeysTranslate.statsAreas),
          ),
          SizedBox(height: 16.h),
          _buildQuickStatItem(
            Icons.verified,
            '15',
            l10n.translate(KeysTranslate.statsExperience),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatItem(IconData icon, String value, String label) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AlessamyColors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AlessamyColors.white, size: 22.sp),
        ),
        SizedBox(width: 14.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AlessamyColors.white,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: AlessamyColors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onViewAll,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: AlessamyColors.textPrimary,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AlessamyColors.textLight,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: onViewAll,
            icon: Icon(Icons.arrow_forward, size: 20.sp),
            label: Text(
              l10n.translate(KeysTranslate.viewAll),
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AlessamyColors.primaryGold,
              foregroundColor: AlessamyColors.black,
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProperties() {
    final properties = _getDemoProperties().where((p) => p.isFeatured).toList();

    return SizedBox(
      height: 360.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        itemCount: properties.length,
        separatorBuilder: (context, index) => SizedBox(width: 24.w),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 340.w,
            child: PropertyCardWidget(
              property: properties[index],
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

  Widget _buildLatestPropertiesSliver() {
    final properties = _getDemoProperties().take(6).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final targetCardWidth = 360.w; // desired card width
        int crossAxisCount = (width / targetCardWidth).floor();
        crossAxisCount = crossAxisCount.clamp(3, 6);
        final spacing = 24.w;
        final totalSpacing = spacing * (crossAxisCount - 1);
        final availableWidth =
            width - 96.w - totalSpacing; // 48 padding on both sides
        final itemWidth = availableWidth / crossAxisCount;
        final itemHeight = itemWidth * 1.22; // maintain visual ratio
        final childAspectRatio = itemWidth / itemHeight;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: spacing,
              mainAxisSpacing: 24.h,
            ),
            itemCount: properties.length,
            itemBuilder: (context, index) {
              return PropertyCardWidget(
                property: properties[index],
                onTap: () {},
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(48.w),
      margin: EdgeInsets.symmetric(horizontal: 48.w),
      decoration: BoxDecoration(
        gradient: AlessamyColors.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AlessamyColors.primaryGold.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            Icons.home_work,
            '500+',
            AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.statsProperties),
          ),
          _buildVerticalDivider(),
          _buildStatItem(
            Icons.people,
            '1000+',
            AppLocalizations.of(context)!.translate(KeysTranslate.statsClients),
          ),
          _buildVerticalDivider(),
          _buildStatItem(
            Icons.location_city,
            '50+',
            AppLocalizations.of(context)!.translate(KeysTranslate.statsAreas),
          ),
          _buildVerticalDivider(),
          _buildStatItem(
            Icons.verified,
            '15+',
            AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.statsExperience),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 70.h,
      width: 2.w,
      color: AlessamyColors.black.withValues(alpha: 0.2),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AlessamyColors.black, size: 46.sp),
        SizedBox(height: 14.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.bold,
            color: AlessamyColors.black,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 17.sp,
            color: AlessamyColors.black.withValues(alpha: 0.8),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 40.h),
      color: AlessamyColors.black,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterIcon(Icons.facebook),
              SizedBox(width: 28.w),
              _buildFooterIcon(Icons.chat),
              SizedBox(width: 28.w),
              _buildFooterIcon(Icons.phone),
              SizedBox(width: 28.w),
              _buildFooterIcon(Icons.email),
            ],
          ),
          SizedBox(height: 28.h),
          Container(
            height: 1,
            width: 220.w,
            color: AlessamyColors.primaryGold.withValues(alpha: 0.3),
          ),
          SizedBox(height: 28.h),
          Text(
            AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.rightsReserved),
            style: TextStyle(
              fontSize: 15.sp,
              color: AlessamyColors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AlessamyColors.primaryGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AlessamyColors.primaryGold.withValues(alpha: 0.3),
        ),
      ),
      child: Icon(icon, color: AlessamyColors.primaryGold, size: 26.sp),
    );
  }

  List<PropertyModel> _getDemoProperties() {
    return [
      PropertyModel(
        id: '1',
        code: '5001',
        title: 'شقة فاخرة في الرحاب',
        description: 'شقة 3 غرف نوم مع إطلالة رائعة',
        price: 3500000,
        location: 'الرحاب',
        city: 'القاهرة',
        imageUrl:
            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=500',
        type: PropertyType.apartment,
        purpose: PropertyPurpose.sale,
        bedrooms: 3,
        bathrooms: 2,
        area: 150,
        isFeatured: true,
        createdAt: DateTime.now(),
      ),
      PropertyModel(
        id: '2',
        code: '5002',
        title: 'فيلا مستقلة في مدينتي',
        description: 'فيلا 5 غرف نوم مع حديقة خاصة',
        price: 7500000,
        location: 'مدينتي',
        city: 'القاهرة',
        imageUrl:
            'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=500',
        type: PropertyType.villa,
        purpose: PropertyPurpose.sale,
        bedrooms: 5,
        bathrooms: 4,
        area: 350,
        isFeatured: true,
        createdAt: DateTime.now(),
      ),
      PropertyModel(
        id: '3',
        code: '5003',
        title: 'بنتهاوس فخم في التجمع',
        description: 'بنتهاوس 4 غرف نوم مع تراس كبير',
        price: 5500000,
        location: 'التجمع الخامس',
        city: 'القاهرة',
        imageUrl:
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=500',
        type: PropertyType.penthouse,
        purpose: PropertyPurpose.sale,
        bedrooms: 4,
        bathrooms: 3,
        area: 250,
        isFeatured: true,
        createdAt: DateTime.now(),
      ),
    ];
  }
}
