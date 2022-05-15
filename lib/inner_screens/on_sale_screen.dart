import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () => Navigator.pop(context),
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Products on sale",
          color: color,
          textSize: 24.0,
          isTilte: true,
        ),
      ),
      body: isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/box.png",
                      scale: 1.5,
                    ),
                    Text(
                      "No products on sale yet!, \n Stay tuned",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: color,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.45),
              children: List.generate(16, (index) => const OnSaleWidget()),
            ),
    );
  }
}
