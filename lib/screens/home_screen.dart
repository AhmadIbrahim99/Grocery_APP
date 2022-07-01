import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/feeds_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/feed_items_widget.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/constss.dart';
import '../models/products.dart';
import '../providers/products_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    final Color color = utils.getColor;
    final themState = utils.getThem;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> products = productsProvider.getProducts;
    List<ProductModel> productsOnSale = productsProvider.getOnSaleProducts;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              child: Swiper(
                itemBuilder: (context, index) => Image.asset(
                  Constss.offerImages[index],
                  fit: BoxFit.fill,
                ),
                autoplay: true,
                itemCount: Constss.offerImages.length,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white, activeColor: Colors.red),
                ),
                // control: const SwiperControl(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            TextButton(
                onPressed: () => GlobalMethods.navigateTo(
                    ctx: context, name: OnSaleScreen.routeName),
                child: TextWidget(
                  color: Colors.blue,
                  text: 'View all',
                  textSize: 19,
                )),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'On Sale'.toUpperCase(),
                        color: Colors.red,
                        textSize: 22,
                        isTilte: true,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        IconlyLight.discount,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.23,
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider.value(
                              value: productsOnSale[index],
                              child: const OnSaleWidget()),
                      itemCount: productsOnSale.length < 10
                          ? productsOnSale.length
                          : 10,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Our products",
                    color: color,
                    textSize: 21,
                    isTilte: true,
                  ),
                  // const Spacer(),
                  TextButton(
                      onPressed: () => GlobalMethods.navigateTo(
                          ctx: context, name: FeedsScreen.routeName),
                      child: TextWidget(
                          maxLines: 1,
                          text: "Browse all",
                          color: Colors.blue,
                          textSize: 19)),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              childAspectRatio: size.width / (size.height * 0.6),
              children: List.generate(
                products.length < 4 ? products.length : 4,
                (index) => ChangeNotifierProvider.value(
                  value: products[index],
                  child: const FeedsWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
