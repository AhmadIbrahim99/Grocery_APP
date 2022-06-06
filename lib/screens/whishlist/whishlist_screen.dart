import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/whishlist/whishlist_widget.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../services/global_methods.dart';
import '../../widgets/empty_screen.dart';

class WhishListScreen extends StatelessWidget {
  static const routeName = "/WhishListScreen";
  const WhishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;
    bool _isEmpty = true;
    return _isEmpty
        ? const EmptyScreen(
            buttonText: 'Shop Now',
            imgPath: 'assets/images/wishlist.png',
            subTitle: 'Explore more and shortlist some items',
            title: 'Your Whishlist is Empty',
          )
        : Scaffold(
            appBar: AppBar(
                leading: const BackWidget(),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                centerTitle: true,
                title: TextWidget(
                  text: 'Whishlist (2)',
                  color: color,
                  textSize: 22,
                  isTilte: true,
                ),
                actions: [
                  IconButton(
                      onPressed: () => GlobalMethods.warningDialog(
                          function: () => log("Delete your Whishlist?!!"),
                          title: 'Empty your Whishlist?!',
                          hintText: 'Are you sure?!!',
                          textButton: 'yes',
                          context: context),
                      color: color,
                      icon: const Icon(IconlyLight.delete))
                ]),
            body: MasonryGridView.count(
              crossAxisCount: 2,
              // mainAxisSpacing: 4,
              // crossAxisSpacing: 4,
              itemBuilder: (context, index) => const WhishlistWidget(),
              itemCount: 9,
            ),
          );
  }
}
