import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/products.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_const.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../screens/auth/login.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  final User? user = firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final theme = utils.getThem;
    final Color color = utils.getColor;
    Size size = utils.getScreenSize;
    final productsOnSale = Provider.of<ProductModel>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool _isInCart = cartProvider.getCartItems.containsKey(productsOnSale.id);
    final _wishListProvider = Provider.of<WishListProvider>(context);
    bool _isInWishList =
        _wishListProvider.getWishListItems.containsKey(productsOnSale.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => GlobalMethods.navigateTo(
              ctx: context,
              name: ProductDetailScreen.routeName,
              arguments: productsOnSale.id),
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
                      imageUrl: productsOnSale.imageUrl,
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
                          text: productsOnSale.isPiece ? '1Piece' : "1KG",
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
                              onTap: () async {
                                if (user == null) {
                                  GlobalMethods.errorDialog(
                                      function: () => GlobalMethods.navigateTo(
                                          ctx: context,
                                          name: LoginScreen.routeName),
                                      title: 'Error',
                                      hintText: 'Plz login first',
                                      textButton: 'Ok',
                                      context: context);
                                  return;
                                }
                                if (cartProvider.getCartItems
                                    .containsKey(productsOnSale.id)) return;
                                await GlobalMethods.addToCart(
                                    prodId: productsOnSale.id,
                                    quantity: 1,
                                    context: context);
                                await cartProvider.fetchCart();
                                // cartProvider.addProduct(
                                //   productId: productsOnSale.id,
                                //   quantity: 1,
                                // );
                              },
                              child: Icon(
                                _isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                                size: 21,
                                color: _isInCart ? Colors.green : color,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            HeartButton(
                              productId: productsOnSale.id,
                              isInWishlist: _isInWishList,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                PriceWidget(
                    salesPrice: productsOnSale.salePrice,
                    price: productsOnSale.price,
                    textPrice: "1",
                    isOnSale: productsOnSale.isOnSale),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  flex: 6,
                  child: TextWidget(
                    text: productsOnSale.title,
                    color: color,
                    textSize: 16,
                    maxLines: 1,
                    isTilte: true,
                  ),
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
