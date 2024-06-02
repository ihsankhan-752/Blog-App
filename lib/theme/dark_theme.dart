import 'package:blog_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFF1a6985)),
  ),
  colorScheme: ColorScheme.dark(
      background: Colors.black,
      primary: Color(0xFF1a6985),
      secondary: AppColors.primaryLightBlack),
);
