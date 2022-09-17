import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getThem => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get getColor => getThem ? Colors.white : Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}
