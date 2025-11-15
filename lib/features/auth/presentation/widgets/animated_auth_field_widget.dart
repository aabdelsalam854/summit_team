import 'package:flutter/material.dart';

/// Widget للـ Animation المتأخر لكل عنصر في الفورم
/// يعمل مرة واحدة فقط بناءً على delay
class AnimatedAuthFieldWidget extends StatefulWidget {
  const AnimatedAuthFieldWidget({
    super.key,
    required this.child,
    required this.delay,
  });

  final Widget child;
  final int delay;

  @override
  State<AnimatedAuthFieldWidget> createState() =>
      _AnimatedAuthFieldWidgetState();
}

class _AnimatedAuthFieldWidgetState extends State<AnimatedAuthFieldWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimation();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  void _startAnimation() {
    // Animation يعمل مرة واحدة فقط
    if (!_hasAnimated) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          _controller.forward();
          _hasAnimated = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
