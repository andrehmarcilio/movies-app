import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData appTheme(BuildContext context) {
    final currentBrightness = MediaQuery.of(context).platformBrightness;
    if (currentBrightness == Brightness.dark) {
      return _darkTheme;
    }
    return _lightTheme;
  }

  static final _darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.purple,
      primary: AppColors.purple,
      secondary: AppColors.lightPurple,
      background: AppColors.black,
      brightness: Brightness.dark,
    ),
  );

  static final _lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.purple,
      primary: AppColors.purple,
      secondary: AppColors.deepPurple,
      background: AppColors.lightPurple,
    ),
  );
}
