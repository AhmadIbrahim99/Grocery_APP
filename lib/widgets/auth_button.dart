import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {Key? key,
      required this.fct,
      required this.buttonText,
      this.primary = Colors.white38,
      this.keyName})
      : super(key: key);
  final Function fct;
  final String buttonText;
  final Color primary;
  final String? keyName;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          key: keyName != null ? Key(keyName!) : null,
          style: ElevatedButton.styleFrom(primary: primary),
          onPressed: () => fct(),
          child: TextWidget(
            text: buttonText,
            color: Colors.white,
            textSize: 18,
          ),
        ),
      );
}
