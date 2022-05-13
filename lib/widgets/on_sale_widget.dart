import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final theme = utils.getThem;
    final Color color = utils.getColor;
    Size size = utils.getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyShimmerImage(
                      imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
                      height: size.width * 0.21,
                      width: size.width * 0.21,
                      boxFit: BoxFit.fill,
                    ),
                    // Image.network(
                    //   "https://i.ibb.co/F0s3FHQ/Apricots.png",
                    //   // width: size.width * 0.21,
                    //   height: size.width * 0.21,
                    //   fit: BoxFit.fill,
                    // ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        TextWidget(
                          text: "1KG",
                          color: color,
                          textSize: 21,
                          isTilte: true,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                IconlyLight.bag2,
                                size: 21,
                                color: color,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const HeartButton(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const PriceWidget(
                    salesPrice: 2.99,
                    price: 5.9,
                    textPrice: "1",
                    isOnSale: true),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  text: "Product Title",
                  color: color,
                  textSize: 16,
                  isTilte: true,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
