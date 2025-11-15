import 'package:summit_team/core/utils/app_colors.dart';
import 'package:summit_team/features/auth/presentation/widgets/auth_animation_controller_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/auth_background_widget.dart';
import 'package:summit_team/features/auth/presentation/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

class TabletLoginLayout extends StatefulWidget {
  const TabletLoginLayout({super.key});

  @override
  State<TabletLoginLayout> createState() => _TabletLoginLayoutState();
}

class _TabletLoginLayoutState extends State<TabletLoginLayout> {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.richBlack,
      body: AuthAnimationControllerWidget(
        child: Stack(
          children: [
            // Background
            const AuthBackgroundWidget(),

            // Decorative elements
            _buildDecorativeElements(screenWidth, screenHeight),

            // Main content
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.05,
                ),
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
                        width: screenWidth * 0.80,
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: _buildLoginForm(screenWidth, screenHeight),
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

  Widget _buildDecorativeElements(double screenWidth, double screenHeight) {
    return RepaintBoundary(
      child: Stack(
        children: [
          // Top-left decorative element
          Positioned(
            top: -screenHeight * 0.1,
            left: -screenWidth * 0.08,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                width: screenWidth * 0.3,
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.7),
                      AppColors.primary.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.4, 0.7, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(80),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 100,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom-right decorative element
          Positioned(
            bottom: -screenHeight * 0.1,
            right: -screenWidth * 0.08,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: screenWidth * 0.3,
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.gold,
                      AppColors.gold.withValues(alpha: 0.6),
                      AppColors.gold.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.4, 0.7, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(80),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.3),
                      blurRadius: 100,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Additional decorative elements
          Positioned(
            top: screenHeight * 0.15,
            right: screenWidth * 0.1,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.gold.withValues(alpha: 0.4),
                    AppColors.gold.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.2),
                    blurRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: screenHeight * 0.2,
            left: screenWidth * 0.08,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.35),
                    AppColors.primary.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(double screenWidth, double screenHeight) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(56),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.white.withValues(alpha: 0.1),
              AppColors.white.withValues(alpha: 0.06),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.15),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.5),
              blurRadius: 60,
              offset: const Offset(10, 25),
            ),
            BoxShadow(
              color: AppColors.gold.withValues(alpha: 0.1),
              blurRadius: 90,
              offset: const Offset(0, 35),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Login header
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.goldGradient.createShader(bounds),
                child: const Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Elite Properties Portal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 48),

              // Email field
              CustomTextFieldWidget(
                controller: _emailController,
                hintText: 'Email Address',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
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

              const SizedBox(height: 24),

              // Password field
              CustomTextFieldWidget(
                controller: _passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock_outline,
                isPassword: true,
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

              const SizedBox(height: 16),

              // Remember me & Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 26,
                        height: 26,
                        child: Checkbox(
                          value: false,
                          onChanged: (value) {},
                          fillColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return AppColors.gold;
                            }
                            return AppColors.white.withValues(alpha: 0.25);
                          }),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Remember me',
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.75),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.goldGradient.createShader(bounds),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Login button
              ValueListenableBuilder<bool>(
                valueListenable: _isLoadingNotifier,
                builder: (context, isLoading, child) {
                  return Container(
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.5),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.3),
                          blurRadius: 50,
                          offset: const Offset(0, 25),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 28,
                              width: 28,
                              child: CircularProgressIndicator(
                                color: AppColors.richBlack,
                                strokeWidth: 3.5,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: AppColors.richBlack,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 19,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: AppColors.richBlack,
                                  size: 24,
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.gold.withValues(alpha: 0.5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'OR CONTINUE WITH',
                      style: TextStyle(
                        color: AppColors.gold.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.gold.withValues(alpha: 0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.75),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.goldGradient.createShader(bounds),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
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
