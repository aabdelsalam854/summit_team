import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:flutter/material.dart';

import 'package:summit_team/config/locale/app_localizations.dart';
import 'package:summit_team/config/locale/keys_translate.dart';


class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool isDesktop = width >= 1200;
    final l10n = AppLocalizations.of(context)!;

    return AppBar(
      backgroundColor: AlessamyColors.white,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      title: Row(
        children: [
          Icon(Icons.home_work, color: AlessamyColors.primaryGold, size: 32),
          SizedBox(width: 8),
          Text(
            l10n.translate(KeysTranslate.appName),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AlessamyColors.primaryGold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_outlined,
            color: AlessamyColors.darkGray,
            size: 24,
          ),
        ),

        // زر المفضلة
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_border,
            color: AlessamyColors.darkGray,
            size: 24,
          ),
        ),

        if (isDesktop) ...[
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.translate(KeysTranslate.menuHome),
              style: TextStyle(
                color: AlessamyColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(
                context,
              )!.translate(KeysTranslate.menuFeatured),
              style: TextStyle(
                color: AlessamyColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.translate(KeysTranslate.menuAbout),
              style: TextStyle(
                color: AlessamyColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ] else ...[
          // زر القائمة على الشاشات الأصغر
          IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: Icon(Icons.menu, color: AlessamyColors.darkGray, size: 24),
          ),
        ],
        SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AlessamyColors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: AlessamyColors.primaryGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.home_work, color: AlessamyColors.white, size: 48),
                SizedBox(height: 8),
                Text(
                  AppLocalizations.of(
                    context,
                  )!.translate(KeysTranslate.appName),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AlessamyColors.white,
                  ),
                ),
              ],
            ),
          ),
          _buildMenuItem(
            icon: Icons.home,
            title: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.menuHome),
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.apartment,
            title: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.menuFeatured),
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.search,
            title: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.menuAdvancedSearch),
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.add_home,
            title: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.menuAddProperty),
            onTap: () {},
          ),
          const Divider(),
          _buildMenuItem(
            icon: Icons.article_outlined,
            title: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.menuNews),
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.support_agent,
            title: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.menuSupport),
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.info_outline,
            title: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.menuAbout),
            onTap: () {},
          ),
          const Divider(),
          _buildMenuItem(
            icon: Icons.settings,
            title: AppLocalizations.of(
              context,
            )!.translate(KeysTranslate.menuSettings),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AlessamyColors.primaryGold, size: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AlessamyColors.black,
        ),
      ),
      onTap: onTap,
    );
  }
}
