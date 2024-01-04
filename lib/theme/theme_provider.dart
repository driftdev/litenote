import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notelite/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData;

  ThemeProvider() {
    final Brightness systemBrightness =  SchedulerBinding.instance.platformDispatcher.platformBrightness;
    _themeData = systemBrightness == Brightness.dark ? darkMode : lightMode;
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}