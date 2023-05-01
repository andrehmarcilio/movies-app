import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.purple,
        primary: AppColors.deepPurple,
        secondary: AppColors.deepPurple,
        background: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.purple,
        primary: AppColors.purple,
        onPrimary: AppColors.white,
        background: AppColors.black,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.black,
    );
  }
}
