import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/inner_screens/cat_screen.dart';
import 'package:grocery_app/providers/dark_theme_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget(
      {Key? key,
      required this.name,
      required this.imgPath,
      required this.catColor})
      : super(key: key);
  String name, imgPath;
  final Color catColor;
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context);
    final Color color = themeData.getDarkTheme ? Colors.white : Colors.black;
    Size _screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => GlobalMethods.navigateTo(
        ctx: context,
        name: CategoryScreen.routeName,
        arguments: name,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: catColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: catColor.withOpacity(0.7), width: 2),
        ),
        child: Column(
          children: [
            Container(
              height: _screenSize.width * 0.3,
              width: _screenSize.width * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgPath), fit: BoxFit.fill)),
            ),
            TextWidget(text: name, color: color, textSize: 20)
          ],
        ),
      ),
    );
  }
}
