import 'package:summit_team/core/utils/app_colors.dart';
import 'package:summit_team/features/auth/presentation/widgets/auth_animation_controller_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/auth_background_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/custom_text_field_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/decorative_circle_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/feature_badge_widget.dart';
import 'package:flutter/material.dart';

class DesktopLoginLayout extends StatefulWidget {
  const DesktopLoginLayout({super.key});

  @override
  State<DesktopLoginLayout> createState() => _DesktopLoginLayoutState();
}

class _DesktopLoginLayoutState extends State<DesktopLoginLayout> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _isLoading = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AuthAnimationControllerWidget(
        child: Stack(
          children: [
            // Background
            const AuthBackgroundWidget(),

            // Decorative circles
            Positioned(
              top: -screenHeight * 0.1,
              left: -screenWidth * 0.05,
              child: DecorativeCircleWidget(
                size: screenWidth * 0.25,
                color: AppColors.gold,
              ),
            ),
            Positioned(
              bottom: -screenHeight * 0.1,
              right: -screenWidth * 0.05,
              child: DecorativeCircleWidget(
                size: screenWidth * 0.25,
                color: AppColors.gold,
              ),
            ),

            // Main content with animation
            Center(
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
                    child: Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.8,
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Row(
                        children: [
                          // Info section
                          Expanded(flex: 5, child: _buildInfoSection()),

                          SizedBox(width: screenWidth * 0.05),

                          // Login form
                          Expanded(flex: 5, child: _buildLoginCard()),
                        ],
                      ),
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

  Widget _buildInfoSection() {
    return RepaintBoundary(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.business_center_rounded,
            size: 80,
            color: AppColors.gold,
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome to Elite Properties',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Manage your properties efficiently and securely with our platform.',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.white.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 30),
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FeatureBadgeWidget(icon: Icons.security, text: "Secure"),
              FeatureBadgeWidget(icon: Icons.speed, text: "Fast"),
              FeatureBadgeWidget(icon: Icons.analytics, text: "Analytics"),
              FeatureBadgeWidget(
                icon: Icons.support_agent,
                text: "24/7 Support",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard() {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your credentials',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),
              CustomTextFieldWidget(
                controller: _emailController,
                hintText: 'Email Address',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter email';
                  if (!value.contains('@')) return 'Invalid email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextFieldWidget(
                controller: _passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter password';
                  if (value.length < 6) return 'Min 6 chars';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (v) {},
                        activeColor: AppColors.gold,
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: AppColors.richBlack,
                        )
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.richBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: AppColors.white),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
