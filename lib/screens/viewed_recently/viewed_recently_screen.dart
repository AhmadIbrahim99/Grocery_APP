import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/providers/viewed_provider.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently_widget.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/empty_screen.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const roteName = '/ViewedRecentlyScreen';
  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  State<ViewedRecentlyScreen> createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final viewedProvider = Provider.of<ViewedProductProvider>(context);
    final viewedProductList =
        viewedProvider.getViewedProductItems.values.toList().reversed.toList();
    return viewedProductList.isEmpty
        ? const EmptyScreen(
            buttonText: 'Your History is empty',
            imgPath: 'assets/images/history.png',
            subTitle: 'No products has been viewd yet!',
            title: 'Your history is Empty',
          )
        : Scaffold(
            appBar: AppBar(
                leading: const BackWidget(),
                backgroundColor:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                elevation: 0,
                centerTitle: true,
                title: TextWidget(
                  text: 'History',
                  color: color,
                  textSize: 24,
                  isTilte: true,
                ),
                actions: [
                  IconButton(
                      onPressed: () => GlobalMethods.warningDialog(
                          function: () => log("Delete your History?!!"),
                          title: 'Empty your History?!',
                          hintText: 'Are you sure?!!',
                          textButton: 'yes',
                          context: context),
                      color: color,
                      icon: const Icon(IconlyLight.delete))
                ]),
            body: ListView.builder(
              itemCount: viewedProductList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                child: ChangeNotifierProvider.value(
                    value: viewedProductList[index],
                    child: const ViewedRecentlyWidget()),
              ),
            ),
          );
  }
}
