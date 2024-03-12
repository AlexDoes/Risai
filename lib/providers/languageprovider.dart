import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String _language = 'English';

  LanguageProvider() {
    _loadLanguage();
  }

  String get language => _language;

  Future<void> _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedLanguage = prefs.getString('language');
    if (storedLanguage != null) {
      _language = storedLanguage;
      notifyListeners();
    }
  }

  void setLanguage(String newLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = newLanguage;
    await prefs.setString('language', newLanguage);
    notifyListeners();
  }

  void toggleLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _language == 'English' ? _language = 'Japanese' : _language = 'English';
    await prefs.setString('language', _language);
    notifyListeners();
  }
}
