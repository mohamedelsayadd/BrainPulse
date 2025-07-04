import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  Locale get currentLocale => _currentLocale;

  LocaleProvider() {
    loadSavedLocale();
  }

  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLocale = prefs.getString('selected_locale');
    if (savedLocale != null) {
      _currentLocale = Locale(savedLocale);
      notifyListeners();
    }
  }

  Future<void> setLocale(String languageCode) async {
    _currentLocale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', languageCode);
    notifyListeners();
  }
}
