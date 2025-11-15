import 'package:flutter/material.dart';

/// نظام الألوان الخاص بتطبيق العصامي جروب (Alessamy)
/// الألوان الرئيسية: الذهبي والأسود
class AlessamyColors {
  AlessamyColors._();

  // Primary Colors - Gold Theme
  static const Color primaryGold = Color(0xFFD4AF37); // ذهبي كلاسيكي
  static const Color lightGold = Color(0xFFFFD700); // ذهبي فاتح
  static const Color darkGold = Color(0xFFB8860B); // ذهبي داكن
  static const Color accentGold = Color(0xFFFFC107); // ذهبي لامع

  // Black Shades
  static const Color black = Color(0xFF000000);
  static const Color richBlack = Color(0xFF0A0A0A);
  static const Color charcoalBlack = Color(0xFF1A1A1A);
  static const Color darkGray = Color(0xFF2D2D2D);
  static const Color mediumGray = Color(0xFF4A4A4A);
  static const Color lightGray = Color(0xFF8A8A8A);

  // White and Light Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color lightBackground = Color(0xFFFAFAFA);

  // Background Colors
  static const Color backgroundColor = richBlack;
  static const Color cardBackground = charcoalBlack;
  static const Color overlayDark = Color(0xCC000000); // 80% black overlay

  // Text Colors
  static const Color textPrimary = black;
  static const Color textSecondary = lightGray;
  static const Color textLight = mediumGray;
  static const Color textOnGold = black;
  static const Color textOnBlack = white;

  // Border Colors
  static const Color borderLight = Color(0xFF3A3A3A);
  static const Color borderMedium = Color(0xFF2A2A2A);
  static const Color borderGold = primaryGold;

  // Status Colors
  static const Color success = Color(0xFF10B981); // أخضر
  static const Color warning = Color(0xFFF59E0B); // برتقالي
  static const Color error = Color(0xFFEF4444); // أحمر
  static const Color info = accentGold;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [darkGold, primaryGold, lightGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [darkGold, primaryGold],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient blackGradient = LinearGradient(
    colors: [black, richBlack, charcoalBlack],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient overlayGradient = LinearGradient(
    colors: [Colors.transparent, overlayDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient goldToBlackGradient = LinearGradient(
    colors: [primaryGold, darkGold, charcoalBlack],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
