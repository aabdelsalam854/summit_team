import 'package:summit_team/config/themes/app_theme.dart';
import 'package:summit_team/core/enums/theme.dart';
import 'package:flutter/material.dart';

ThemeData resolveAppTheme(AppTheme appTheme, String fontFamily) {
  return appTheme == AppTheme.themeLight
      ? AppThemes.light(fontFamily)
      : AppThemes.dark(fontFamily);
}
