import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:summit_team/config/locale/app_localizations.dart';
import 'package:summit_team/config/locale/keys_translate.dart';
import 'package:summit_team/config/routes/routes.dart';

import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/dashboard/presentation/screens/desktop_dashboard_layout.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/custom_app_bar_sliever.dart';
import 'package:summit_team/features/home/presentation/screens/search_view.dart';
import 'package:summit_team/features/home/presentation/widgets/custom_app_bar_widget.dart';
import 'package:summit_team/features/home/presentation/widgets/footer_widget.dart';

import 'package:summit_team/features/home/presentation/widgets/search_filter_widget.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'package:summit_team/features/properties/presentation/widgets/property_card_widget.dart';

/// ---------------------------------------------------------------------------
/// 🟥 MobileHomeLayout — الصفحة الرئيسية للموبايل
/// ---------------------------------------------------------------------------
class MobileHomeLayout extends StatelessWidget {
  const MobileHomeLayout({super.key});

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
            CustomAppBarSliever(),
            SliverToBoxAdapter(child: SizedBox(height: 40)),

            // Search Filter + Quick Stats
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchFilterWidget(onSearch: (filter) {}),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 48)),

            // العقارات المميزة - Header
            SliverToBoxAdapter(
              child: SectionHeaderWidget(
                title: l10n.translate(KeysTranslate.sectionFeatured),
                subtitle: l10n.translate(KeysTranslate.sectionFeaturedSubtitle),
                onViewAll: () {},
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 24)),

            // العقارات المميزة - القائمة
            SliverToBoxAdapter(
              child: FeaturedPropertiesWidget(
                properties: _getDemoProperties()
                    .where((p) => p.isFeatured)
                    .toList(),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 48)),

            // أحدث العروض - Header
            SliverToBoxAdapter(
              child: SectionHeaderWidget(
                title: l10n.translate(KeysTranslate.sectionLatest),
                subtitle: l10n.translate(KeysTranslate.sectionLatestSubtitle),
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DesktopHomes(),
                    ),
                  );
                },
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 24)),

            // أحدث العروض - Grid
            SliverToBoxAdapter(
              child: LatestPropertiesGrid(
                
                
                properties: _getDemoProperties()),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 48)),

            // Footer
            SliverToBoxAdapter(child: FooterWidget()),
          ],
        ),
      ),
    );
  }

  /// بيانات تجريبية للعقارات
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
        description: 'فيلا 5 غرف نوم مع حديقة',
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
        description: 'بنتهاوس 4 غرف نوم',
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

/// ---------------------------------------------------------------------------
/// 🟩 SectionHeaderWidget — عنوان القسم (العقارات المميزة / أحدث العروض)
/// ---------------------------------------------------------------------------
// class SectionHeaderWidget extends StatelessWidget {
//   const SectionHeaderWidget({
//     super.key,
//     required this.title,
//     required this.onViewAll,
//   });

//   final String title;
//   final VoidCallback onViewAll;

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 12.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.bold,
//               color: AlessamyColors.white,
//             ),
//           ),
//           TextButton(
//             onPressed: onViewAll,
//             child: Row(
//               children: [
//                 Text(
//                   l10n.translate(KeysTranslate.viewAll),
//                   style: TextStyle(
//                     fontSize: 11.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AlessamyColors.primaryGold,
//                   ),
//                 ),
//                 SizedBox(width: 3.w),
//                 Icon(
//                   Icons.arrow_forward,
//                   size: 12.sp,
//                   color: AlessamyColors.primaryGold,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// ---------------------------------------------------------------------------
// /// 🟦 FeaturedPropertiesList — قائمة العقارات المميزة (أفقية)
// /// ---------------------------------------------------------------------------

class FeaturedPropertiesList extends StatelessWidget {
  const FeaturedPropertiesList({super.key, required this.properties, this.scrollDirection});

  final List<PropertyModel> properties;
  final Axis? scrollDirection;

  @override
  Widget build(BuildContext context) {
    final featured = properties.where((p) => p.isFeatured).toList();

    return SizedBox(
      height: 380,
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          scrollbars: false,
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.trackpad,
          },
        ),
        child: ListView.separated(
          scrollDirection: scrollDirection ?? Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 12),
          itemCount: featured.length,
          separatorBuilder: (context, index) => SizedBox(width: 10),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 260,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PropertyCardWidget(
                  property: featured[index],
                  onTap: () {
                    context.push(
                      '${Routes.kPropertyDetails}/${featured[index].id}',
                      extra: featured[index],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// /// يجعل ListView تستجيب للـ mouse wheel على الويب والديسكتوب
// class MouseScrollBehavior extends ScrollBehavior {
//   @override
//   ScrollPhysics getScrollPhysics(BuildContext context) {
//     return const ClampingScrollPhysics(); // أفضل لتجربة الفأرة
//   }

//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//     PointerDeviceKind.touch,
//     PointerDeviceKind.mouse, // مهم للفأرة
//     PointerDeviceKind.stylus,
//     PointerDeviceKind.unknown,
//   };
// }

// /// ---------------------------------------------------------------------------
// /// 🟨 LatestPropertiesList — أحدث العقارات (رأسي)
// /// ---------------------------------------------------------------------------
// class LatestPropertiesList extends StatelessWidget {
//   const LatestPropertiesList({super.key, required this.properties});

//   final List<PropertyModel> properties;

//   @override
//   Widget build(BuildContext context) {
//     final latest = properties.take(4).toList();
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 12.w),
//       child: Column(
//         children: latest.map((property) {
//           return Padding(
//             padding: EdgeInsets.only(bottom: 10.h),
//             child: PropertyCardWidget(property: property, onTap: () {}),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// /// ---------------------------------------------------------------------------
// /// 🟧 FooterWidget — الفوتر السفلي
// /// ---------------------------------------------------------------------------
// class FooterWidget extends StatelessWidget {
//   const FooterWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       color: AlessamyColors.black,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.facebook,
//                   color: AlessamyColors.white,
//                   size: 20.sp,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.chat,
//                   color: AlessamyColors.white,
//                   size: 20.sp,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.phone,
//                   color: AlessamyColors.white,
//                   size: 20.sp,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10.h),
//           Text(
//             AppLocalizations.of(
//               context,
//             )!.translate(KeysTranslate.rightsReserved),
//             style: TextStyle(
//               fontSize: 10.sp,
//               color: AlessamyColors.white.withValues(alpha: 0.7),
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
