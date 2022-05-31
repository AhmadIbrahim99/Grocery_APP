import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;
    return ListTile(
      title: TextWidget(text: 'Title x12', color: color, textSize: 18),
      trailing: TextWidget(text: "03/08/2022", color: color, textSize: 18),
      subtitle: const Text("Paid: \$12.8"),
      onTap: () => GlobalMethods.navigateTo(
          ctx: context, name: ProductDetailScreen.routeName),
      leading: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: FancyShimmerImage(
          width: size.width * 0.2,
          imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
          boxFit: BoxFit.fill,
        ),
      ),
    );
  }
}
