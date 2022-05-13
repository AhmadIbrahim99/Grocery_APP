import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {Key? key,
      required this.salesPrice,
      required this.price,
      required this.textPrice,
      required this.isOnSale})
      : super(key: key);
  final double salesPrice, price;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    double userPrice = isOnSale ? salesPrice : price;
    return FittedBox(
      child: Row(
        children: [
          TextWidget(
              text:
                  "\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}",
              color: Colors.green,
              textSize: 17),
          const SizedBox(
            width: 5,
          ),
          Visibility(
            visible: isOnSale ? true : false,
            child: Text(
              "\$${(price * int.parse(textPrice)).toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 15,
                  color: color,
                  decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }
}
