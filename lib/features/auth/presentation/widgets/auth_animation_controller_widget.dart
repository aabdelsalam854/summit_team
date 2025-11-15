import 'package:flutter/material.dart';

/// Widget لإدارة الـ Animation بحيث يعمل مرة واحدة فقط
/// يستخدم InheritedWidget لمشاركة الـ AnimationController
class AuthAnimationControllerWidget extends StatefulWidget {
  const AuthAnimationControllerWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AuthAnimationControllerWidget> createState() =>
      _AuthAnimationControllerWidgetState();

  /// الحصول على الـ AnimationController من أي مكان في Widget tree
  static AnimationController? of(BuildContext context) {
    final inherited = context
        .dependOnInheritedWidgetOfExactType<_InheritedAuthAnimation>();
    return inherited?.controller;
  }
}

class _AuthAnimationControllerWidgetState
    extends State<AuthAnimationControllerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    // Animation يعمل مرة واحدة فقط عند initState
    _controller.forward();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedAuthAnimation(
      controller: _controller,
      fadeAnimation: _fadeAnimation,
      slideAnimation: _slideAnimation,
      scaleAnimation: _scaleAnimation,
      child: widget.child,
    );
  }
}

/// InheritedWidget لمشاركة الـ Animations
class _InheritedAuthAnimation extends InheritedWidget {
  const _InheritedAuthAnimation({
    required this.controller,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.scaleAnimation,
    required super.child,
  });

  final AnimationController controller;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final Animation<double> scaleAnimation;

  @override
  bool updateShouldNotify(_InheritedAuthAnimation oldWidget) {
    return controller != oldWidget.controller;
  }

  static _InheritedAuthAnimation? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedAuthAnimation>();
  }
}

/// Extension للحصول على الـ Animations بسهولة
extension AuthAnimationExtension on BuildContext {
  Animation<double>? get fadeAnimation =>
      _InheritedAuthAnimation.of(this)?.fadeAnimation;

  Animation<Offset>? get slideAnimation =>
      _InheritedAuthAnimation.of(this)?.slideAnimation;

  Animation<double>? get scaleAnimation =>
      _InheritedAuthAnimation.of(this)?.scaleAnimation;

  AnimationController? get animationController =>
      _InheritedAuthAnimation.of(this)?.controller;
}
