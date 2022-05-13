import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextWidget extends StatelessWidget {
  TextWidget(
      {Key? key,
      required this.text,
      required this.color,
      required this.textSize,
      this.isTilte = false,
      this.maxLines = 10})
      : super(key: key);
  final String text;
  final Color color;
  final double textSize;
  bool isTilte;
  int maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color,
          fontSize: textSize,
          fontWeight: isTilte ? FontWeight.bold : FontWeight.normal),
    );
  }
}
