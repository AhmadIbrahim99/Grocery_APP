import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/inner_screens/feeds_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
      required this.imgPath,
      required this.title,
      required this.subTitle,
      required this.buttonText})
      : super(key: key);
  final String imgPath, title, subTitle, buttonText;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;
    final themeState = Utils(context).getThem;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Image.asset(
              imgPath,
              height: size.height * 0.4,
              width: double.infinity,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Whoops!",
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(text: title, color: Colors.cyan, textSize: 20),
            const SizedBox(
              height: 20,
            ),
            TextWidget(text: subTitle, color: Colors.cyan, textSize: 20),
            SizedBox(
              height: size.height * 0.1,
            ),
            ElevatedButton(
              onPressed: () => GlobalMethods.navigateTo(
                ctx: context,
                name: FeedsScreen.routeName,
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: color),
                ),
                primary: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 20.0,
                ),
              ),
              child: TextWidget(
                text: buttonText,
                color: themeState ? Colors.grey.shade300 : Colors.grey.shade800,
                textSize: 20,
                isTilte: true,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
