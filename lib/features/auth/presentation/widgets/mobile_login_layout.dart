import 'package:summit_team/core/utils/app_colors.dart';
import 'package:summit_team/features/auth/presentation/widgets/animated_auth_field_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/auth_animation_controller_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/auth_background_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/custom_text_field_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/decorative_circle_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/login_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MobileLoginLayout extends StatefulWidget {
  const MobileLoginLayout({super.key});

  @override
  State<MobileLoginLayout> createState() => _MobileLoginLayoutState();
}

class _MobileLoginLayoutState extends State<MobileLoginLayout> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _isLoadingNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _isLoadingNotifier.value = true;

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _isLoadingNotifier.value = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.richBlack,
      body: AuthAnimationControllerWidget(
        child: Stack(
          children: [
            // الخلفية
            const AuthBackgroundWidget(),

            // العنصر الديكوري المتحرك
            Positioned(
              top: -50.h,
              left: -50.w,
              child: AnimatedBuilder(
                animation:
                    context.animationController ??
                    const AlwaysStoppedAnimation(0),
                builder: (context, child) {
                  final controller = context.animationController;
                  final scale = context.scaleAnimation?.value ?? 1.0;

                  return Transform.rotate(
                    angle: -0.3 + ((controller?.value ?? 0) * 0.1),
                    child: Transform.scale(
                      scale: scale,
                      child: DecorativeCircleWidget(
                        size: 250.r,
                        color: AppColors.primary,
                        opacity: 0.8,
                      ),
                    ),
                  );
                },
              ),
            ),

            // المحتوى الرئيسي
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: FadeTransition(
                  opacity:
                      context.fadeAnimation ?? const AlwaysStoppedAnimation(1),
                  child: SlideTransition(
                    position:
                        context.slideAnimation ??
                        const AlwaysStoppedAnimation(Offset.zero),
                    child: ScaleTransition(
                      scale:
                          context.scaleAnimation ??
                          const AlwaysStoppedAnimation(1),
                      child: _buildFormCard(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      elevation: 10,
      color: Colors.white.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),

              // Header
              const LoginHeaderWidget(),

              SizedBox(height: 32.h),

              // Email
              AnimatedAuthFieldWidget(
                delay: 400,
                child: CustomTextFieldWidget(
                  controller: _emailController,
                  hintText: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  isMobile: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 16.h),

              // Password
              AnimatedAuthFieldWidget(
                delay: 600,
                child: CustomTextFieldWidget(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  isMobile: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // Login Button
              AnimatedAuthFieldWidget(
                delay: 800,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isLoadingNotifier,
                  builder: (context, isLoading, child) {
                    return Container(
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        gradient: AppColors.goldGradient,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.richBlack,
                              )
                            : Text(
                                'Access Portal',
                                style: TextStyle(
                                  color: AppColors.richBlack,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // Sign Up Link
              AnimatedAuthFieldWidget(
                delay: 1000,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to Elite Properties? ",
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.goldGradient.createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
