import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/order/orders_widget.dart';
import 'package:grocery_app/services/utils.dart';

import '../../services/global_methods.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = "/OrdersScreen";

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    bool _isEmpty = true;
    return _isEmpty
        ? const EmptyScreen(
            buttonText: 'Shop Now',
            imgPath: 'assets/images/add-to-cart.png',
            subTitle: 'Order some thing',
            title: 'You Didnt place any order yet!',
          )
        : Scaffold(
            appBar: AppBar(
                leading: const BackWidget(),
                backgroundColor:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                elevation: 0,
                centerTitle: false,
                title: TextWidget(
                  text: 'Your Orders (2)',
                  color: color,
                  textSize: 24,
                  isTilte: true,
                ),
                actions: [
                  IconButton(
                      onPressed: () => GlobalMethods.warningDialog(
                          function: () => log("Delete your Orders?!!"),
                          title: 'Empty your Orders?!',
                          hintText: 'Are you sure?!!',
                          textButton: 'yes',
                          context: context),
                      color: color,
                      icon: const Icon(IconlyLight.delete))
                ]),
            body: ListView.separated(
                itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                      child: OrderWidget(),
                    ),
                separatorBuilder: (context, index) => Divider(
                      color: color,
                    ),
                itemCount: 9),
          );
  }
}
