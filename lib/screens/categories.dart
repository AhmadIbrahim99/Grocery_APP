import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/categories_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  List<Color> gridColors = [
    const Color(0xff53b175),
    const Color(0xfff8a44c),
    const Color(0xfff7a593),
    const Color(0xffd3b0e0),
    const Color(0xfffde598),
    const Color(0xffb7dff5),
  ];
  final List<Map<String, dynamic>> catInfo = [
    {"imgPath": "assets/images/cat/veg.png", "name": " Vegetables"},
    {"imgPath": "assets/images/cat/fruits.png", "name": " fruits"},
    {"imgPath": "assets/images/cat/grains.png", "name": " grains"},
    {"imgPath": "assets/images/cat/nuts.png", "name": " Nuts"},
    {"imgPath": "assets/images/cat/spices.png", "name": " Spices"},
    {"imgPath": "assets/images/cat/Spinach.png", "name": " Herbs"}
  ];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.getColor;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          color: color,
          text: 'Categories',
          textSize: 24,
          isTilte: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 250 / 240,
          crossAxisSpacing: 11,
          mainAxisSpacing: 11,
          children: List.generate(
              catInfo.length,
              (index) => CategoriesWidget(
                    imgPath: catInfo[index]['imgPath'],
                    catColor: gridColors[index],
                    name: catInfo[index]['name'],
                  )),
        ),
      ),
    );
  }
}
