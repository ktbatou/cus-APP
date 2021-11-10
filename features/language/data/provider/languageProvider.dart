import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLang extends ChangeNotifier {
  Locale _appLocale = Locale('fr');

  fetchLocale() async {
    print("this is _appLocal before SharedPrefrences $_appLocale");
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      notifyListeners();
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
    print("this is _appLocal $_appLocale");
    notifyListeners();
    return Null;
  }

  Locale get appLocal => _appLocale;

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("fr")) {
      _appLocale = Locale("fr");
      await prefs.setString('language_code', 'fr');
      await prefs.setString('countryCode', '');
    } else if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', '');
    }
    notifyListeners();
  }
}
