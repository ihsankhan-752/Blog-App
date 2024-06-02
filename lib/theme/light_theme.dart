import 'package:blog_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      background: AppColors.primaryWhite,
      primary: AppColors.primaryBlue,
      secondary: Colors.grey.shade400),
);
