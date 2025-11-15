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

/// Tablet Layout للصفحة الرئيسية
class TabletHomeLayout extends StatelessWidget {
  const TabletHomeLayout({super.key});

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
              child: SizedBox(height: 28.h),
            ),

            // Search Filter
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SearchFilterWidget(
                  onSearch: (filter) {
                    debugPrint('Tablet Search: $filter');
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 36.h),
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
              child: SizedBox(height: 18.h),
            ),

            // العقارات المميزة - القائمة
            SliverToBoxAdapter(
              child: _buildFeaturedProperties(),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 36.h),
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
              child: SizedBox(height: 18.h),
            ),

            // أحدث العروض - Grid
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  crossAxisSpacing: 18.w,
                  mainAxisSpacing: 18.h,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final properties = _getDemoProperties().take(6).toList();
                    return PropertyCardWidget(
                      property: properties[index],
                      onTap: () {},
                    );
                  },
                  childCount: _getDemoProperties().take(6).length,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 36.h),
            ),

            // Stats
            SliverToBoxAdapter(
              child: _buildStatsSection(context),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 36.h),
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

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onViewAll,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AlessamyColors.textPrimary,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AlessamyColors.textLight,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: onViewAll,
            child: Row(
              children: [
                Text(
                  l10n.translate(KeysTranslate.viewAll),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AlessamyColors.primaryGold,
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(
                  Icons.arrow_forward,
                  size: 16.sp,
                  color: AlessamyColors.primaryGold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProperties() {
    final properties = _getDemoProperties().where((p) => p.isFeatured).toList();

    return SizedBox(
      height: 320.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        itemCount: properties.length,
        separatorBuilder: (context, index) => SizedBox(width: 18.w),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 290.w,
            child: PropertyCardWidget(
              property: properties[index],
              onTap: () {},
            ),
          );
        },
      ),
    );
  }


  Widget _buildStatsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.w),
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        gradient: AlessamyColors.primaryGradient,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.home_work,
            value: '500+',
            label: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.statsProperties),
          ),
          _buildStatItem(
            icon: Icons.people,
            value: '1000+',
            label: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.statsClients),
          ),
          _buildStatItem(
            icon: Icons.verified,
            value: '15+',
            label: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.statsExperience),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: AlessamyColors.black, size: 36.sp),
        SizedBox(height: 10.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: AlessamyColors.black,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AlessamyColors.black.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28.w),
      color: AlessamyColors.black,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.facebook,
                  color: AlessamyColors.white,
                  size: 26.sp,
                ),
              ),
              SizedBox(width: 18.w),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chat,
                  color: AlessamyColors.white,
                  size: 26.sp,
                ),
              ),
              SizedBox(width: 18.w),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.phone,
                  color: AlessamyColors.white,
                  size: 26.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Text(
            AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.rightsReserved),
            style: TextStyle(
              fontSize: 13.sp,
              color: AlessamyColors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  List<PropertyModel> _getDemoProperties() {
    return [
      PropertyModel(
        id: '1',
        code: '5001',
        title: 'شقة فاخرة في الرحاب',
        description: 'شقة 3 غرف نوم',
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
        title: 'فيلا مستقلة',
        description: 'فيلا 5 غرف',
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
        title: 'بنتهاوس فخم',
        description: 'بنتهاوس 4 غرف',
        price: 5500000,
        location: 'التجمع',
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
