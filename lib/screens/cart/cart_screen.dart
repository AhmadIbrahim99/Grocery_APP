import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;
    bool _isEmpty = true;
    return _isEmpty
        ? const EmptyScreen(
            buttonText: 'Shop Now',
            imgPath: 'assets/images/cart.png',
            subTitle: 'Add some Thing',
            title: 'Your cart is Empty',
          )
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                title: TextWidget(
                  text: 'Cart (2)',
                  color: color,
                  textSize: 22,
                  isTilte: true,
                ),
                actions: [
                  IconButton(
                      onPressed: () => GlobalMethods.warningDialog(
                          function: () => log("Delete your cart!!"),
                          title: 'Empty your cart?!',
                          hintText: 'Are you sure?!!',
                          textButton: 'yes',
                          context: context),
                      color: color,
                      icon: Icon(IconlyLight.delete))
                ]),
            body: Column(
              children: [
                _checkOut(
                  context: context,
                  size: size,
                  color: color,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => const CartWidget(),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _checkOut(
          {required BuildContext context,
          required Size size,
          required Color color}) =>
      SizedBox(
        width: double.infinity,
        height: size.height * 0.1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            children: [
              Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget(
                      text: 'Order Now',
                      color: Colors.white,
                      textSize: 20,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              FittedBox(
                child: TextWidget(
                  text: 'Total: \$0.259',
                  color: color,
                  textSize: 17,
                  isTilte: true,
                ),
              )
            ],
          ),
        ),
      );
}
