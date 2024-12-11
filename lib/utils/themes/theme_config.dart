import 'package:flutter/material.dart';
export 'package:training_diary/utils/themes/dark_theme.dart';
export 'package:training_diary/utils/themes/light_theme.dart';

class ThemeConfig with ChangeNotifier {
  bool _isDark = false;

  ThemeMode getThemeMode() => _isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
