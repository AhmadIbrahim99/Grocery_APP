import 'package:flutter/cupertino.dart';
import 'package:grocery_app/services/dark_theme_pref.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemPrefs darkThemPrefs = DarkThemPrefs();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;
  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemPrefs.setDarkTheme(value);
    notifyListeners();
  }
}
