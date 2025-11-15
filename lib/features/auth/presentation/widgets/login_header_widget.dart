import 'package:summit_team/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    // required this.isMobile,
  });

  // final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Real Estate Logo with Gold and Black theme
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.6),
                blurRadius: 30,
                spreadRadius: 3,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.richBlack,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Icon(Icons.home_work, size: 48.sp, color: AppColors.gold),
                SizedBox(height: 8.h),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.goldGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    'SUMMIT',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),

        // Welcome Back
        ShaderMask(
          shaderCallback: (bounds) => AppColors.goldGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(height: 8.h),

        // Elite Properties
        ShaderMask(
          shaderCallback: (bounds) => AppColors.goldGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            'Elite Properties',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Tagline
        Text(
          'Your Gateway to SUMMIT Living',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.darkGrey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
