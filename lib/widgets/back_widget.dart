import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
      child: Icon(
        IconlyLight.arrowLeft2,
        color: color,
        size: 24,
      ),
    );
  }
}
