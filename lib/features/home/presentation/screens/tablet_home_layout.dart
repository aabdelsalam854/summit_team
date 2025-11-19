
import 'package:summit_team/features/dashboard/presentation/widgets/custom_app_bar_sliever.dart';
import 'package:summit_team/features/home/presentation/screens/desktop_home_layout.dart';
import 'package:summit_team/features/home/presentation/screens/search_view.dart';
import 'package:summit_team/features/home/presentation/widgets/footer_widget.dart';
import 'package:summit_team/features/home/presentation/widgets/search_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:summit_team/config/locale/app_localizations.dart';
import 'package:summit_team/config/locale/keys_translate.dart';

/// Tablet Layout للصفحة الرئيسية
class TabletHomeLayout extends StatelessWidget {
  const TabletHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return  SafeArea(
        child: CustomScrollView(
          slivers: [
            // Hero Section
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
                properties: getDemoProperties()
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
              child: LatestPropertiesGrid(properties: getDemoProperties()),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 48)),

            // Footer
            SliverToBoxAdapter(child: FooterWidget()),
          ],
        ),
   
    );
  }
}
