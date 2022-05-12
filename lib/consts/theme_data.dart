import 'package:flutter/material.dart';

class Styels {
  static ThemeData themeData(bool isDark, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDark ? const Color(0xff00001a) : const Color(0xFFFFFFFF),
      primaryColor: Colors.blue,
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary:
                isDark ? const Color(0xff1a1f3c) : const Color(0xffe8fdfd),
            brightness: isDark ? Brightness.dark : Brightness.light,
          ),
      cardColor: isDark ? const Color(0xff0a0d2c) : const Color(0xfff2fdfd),
      canvasColor: isDark ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme:
              isDark ? const ColorScheme.dark() : const ColorScheme.light()),
    );
  }
}
