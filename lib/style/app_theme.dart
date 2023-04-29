import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        primary: AppColors.purple,
        seedColor: AppColors.purple,
        secondary: AppColors.deepPurple,
        background: AppColors.lightPurple,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        primary: AppColors.purple,
        brightness: Brightness.dark,
        seedColor: AppColors.purple,
        background: AppColors.black,
        secondary: AppColors.lightPurple,
      ),
    );
  }
}
