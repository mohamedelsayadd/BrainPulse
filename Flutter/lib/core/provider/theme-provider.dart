import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Theming/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = MyThemeData.lightTheme;
  bool _isDarkMode = false;

  ThemeProvider() {
    loadTheme();
  }

  ThemeData get currentTheme => _currentTheme;
  bool get isDarkMode => _isDarkMode;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _currentTheme =
        _isDarkMode ? MyThemeData.darkTheme : MyThemeData.lightTheme;
    notifyListeners();
  }

  Future<void> setLightTheme() async {
    _isDarkMode = false;
    _currentTheme = MyThemeData.lightTheme;
    await _saveTheme();
  }

  Future<void> setDarkTheme() async {
    _isDarkMode = true;
    _currentTheme = MyThemeData.darkTheme;
    await _saveTheme();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _currentTheme =
        _isDarkMode ? MyThemeData.darkTheme : MyThemeData.lightTheme;
    await _saveTheme();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
