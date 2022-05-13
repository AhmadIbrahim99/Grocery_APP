import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return GestureDetector(
      onTap: () {
        print("Heart Is Here YAAAAAAAY!!!!");
      },
      child: Icon(
        IconlyLight.heart,
        size: 21,
        color: color,
      ),
    );
  }
}
