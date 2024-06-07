import 'package:flutter/material.dart';

class VisibilityController extends ChangeNotifier {
  bool _isVisible = true;

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  bool _isOldPasswordVisible = true;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isOldPasswordVisible => _isOldPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void toggleOldPasswordVisibility() {
    _isOldPasswordVisible = !_isOldPasswordVisible;
    notifyListeners();
  }

  bool get isVisible => _isVisible;

  set visibility(newValue) {
    _isVisible = newValue;
    notifyListeners();
  }
}
