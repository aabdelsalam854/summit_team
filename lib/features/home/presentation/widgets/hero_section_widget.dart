import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:summit_team/config/locale/app_localizations.dart';
import 'package:summit_team/config/locale/keys_translate.dart';

/// Hero Section للصفحة الرئيسية
class HeroSectionWidget extends StatelessWidget {
  const HeroSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final bool isDesktop = width >= 1200;
    final bool isTablet = width >= 800 && width < 1200;
    final double targetHeight = isDesktop ? 480.h : (isTablet ? 380.h : 320.h);

    return Container(
      height: targetHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AlessamyColors.primaryGradient,
        image: DecorationImage(
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=1200',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(alpha: 0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: AlessamyColors.overlayGradient,
        ),
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48.w : 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.translate(KeysTranslate.heroTitle),
              style: TextStyle(
                fontSize: isDesktop ? 56.sp : (isTablet ? 48.sp : 34.sp),
                fontWeight: FontWeight.bold,
                color: AlessamyColors.white,
                height: 1.2,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              l10n.translate(KeysTranslate.heroSubtitle),
              style: TextStyle(
                fontSize: isDesktop ? 22.sp : 18.sp,
                color: AlessamyColors.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 8.h,
              children: [
                _buildActionButton(
                  text: l10n.translate(KeysTranslate.heroActionRequest),
                  icon: Icons.search,
                  isPrimary: true,
                  onTap: () {},
                ),
                _buildActionButton(
                  text: l10n.translate(KeysTranslate.heroActionList),
                  icon: Icons.add_home_outlined,
                  isPrimary: false,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 20.sp,
        color: isPrimary ? AlessamyColors.black : AlessamyColors.primaryGold,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: isPrimary ? AlessamyColors.black : AlessamyColors.primaryGold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? AlessamyColors.primaryGold
            : AlessamyColors.white,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }
}
