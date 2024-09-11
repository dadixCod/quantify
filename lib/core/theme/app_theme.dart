import 'package:flutter/material.dart';
import 'package:quantify/core/constants/app_colors.dart';

class AppTheme {
  AppTheme();
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.bgColor,
    primaryColor: AppColors.maincolor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.maincolor,
      brightness: Brightness.light,
    ),
    hintColor: AppColors.hintColor,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryText,
      ),
    ),
  );
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.darkBgColor,
    primaryColor: AppColors.maincolor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.maincolor,
      brightness: Brightness.dark,
    ),
    hintColor: AppColors.borderDarkColor,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryText,
      ),
    ),
  );
}
