import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String _language = 'English';

  String get language => _language;

  void setLanguage(String newLanguage) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = newLanguage;
    // prefs.setString('language', newLanguage);
    notifyListeners();
  }

  void toggleLanguage() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    _language == 'English' ? _language = 'Japanese' : _language = 'English';
    // prefs.setString('language', _language);
    notifyListeners();
  }
}
