import 'package:busniess_search/features/business_card/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeMode = lightMode;
  ThemeData get themeData => _themeMode;
  bool isDarkMode = false;

  set themeState(ThemeData themeData) {
    _themeMode = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == lightMode) {
      _themeMode = darkMode;
      isDarkMode = true;
    } else {
      _themeMode = lightMode;
      isDarkMode = false;
    }
    notifyListeners();
  }
}

class UrlService {
  static Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
