import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.blue,
        child: InkWell(
          onTap: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                'assets/images/google.png',
                width: 40.0,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            TextWidget(
                text: 'Sign in with Google', color: Colors.white, textSize: 18),
          ]),
        ),
      );
}
