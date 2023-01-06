import 'package:flutter/material.dart';
import 'package:smooth_game_app/core/common/smooth_color.dart';
import 'package:smooth_game_app/core/services/theme_service.dart';

class SmoothThemeController with ChangeNotifier {
  SmoothThemeService themePreference = SmoothThemeService();
  SmoothColor smoothColor = SmoothColor();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    themePreference.setDarkTheme(value);
    notifyListeners();
  }
}
