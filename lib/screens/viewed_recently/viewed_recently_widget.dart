import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/products.dart';
import 'package:grocery_app/models/viewed.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_const.dart';
import '../auth/login.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  State<ViewedRecentlyWidget> createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  final User? user = firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final viewedModel = Provider.of<ViewedProductModel>(context);
    final getCurrentProduct =
        productProvider.getProductById(id: viewedModel.productId);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => GlobalMethods.navigateTo(
          ctx: context,
          name: ProductDetailScreen.routeName,
          arguments: getCurrentProduct.id,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FancyShimmerImage(
              height: size.width * 0.27,
              width: size.width * 0.25,
              imageUrl: getCurrentProduct.imageUrl,
              boxFit: BoxFit.fill,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                TextWidget(
                  text: getCurrentProduct.title,
                  color: color,
                  textSize: 24,
                  isTilte: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextWidget(
                    text: "\$${usedPrice.toStringAsFixed(2)}",
                    color: color,
                    textSize: 20),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Material(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.green,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: _isInCart
                      ? null
                      : () {
                          if (user == null) {
                            GlobalMethods.errorDialog(
                                function: () => GlobalMethods.navigateTo(
                                    ctx: context, name: LoginScreen.routeName),
                                title: 'Error',
                                hintText: 'Plz login first',
                                textButton: 'Ok',
                                context: context);
                            return;
                          }
                          GlobalMethods.addToCart(
                              prodId: getCurrentProduct.id,
                              quantity: 1,
                              context: context);
                          // cartProvider.addProduct(
                          //     productId: getCurrentProduct.id, quantity: 1);
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      _isInCart ? Icons.check : IconlyBold.plus,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
