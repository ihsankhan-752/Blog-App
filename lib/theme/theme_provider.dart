import 'package:blog_app/theme/dark_theme.dart';
import 'package:blog_app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  updateThemData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }
    notifyListeners();
  }

  void toggleTheme(ThemeData newTheme) {
    _themeData = newTheme;
    saveThemePreference();
    notifyListeners();
  }

  Future<void> saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _themeData == darkTheme);
  }
}
