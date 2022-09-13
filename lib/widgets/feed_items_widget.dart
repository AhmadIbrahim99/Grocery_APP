import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/products.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/price_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_const.dart';
import '../providers/wishlist_provider.dart';
import '../screens/auth/login.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);
  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  final User? user = firebaseAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    Color color = utils.getColor;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final _wishListProvider = Provider.of<WishListProvider>(context);
    bool _isInWishList =
        _wishListProvider.getWishListItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () => GlobalMethods.navigateTo(
              ctx: context,
              name: ProductDetailScreen.routeName,
              arguments: productModel.id),
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                height: size.width * 0.21,
                width: size.width * 0.21,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                        text: productModel.title,
                        color: color,
                        maxLines: 1,
                        textSize: 18,
                        isTilte: true,
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: HeartButton(
                          productId: productModel.id,
                          isInWishlist: _isInWishList,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: PriceWidget(
                          salesPrice: productModel.salePrice,
                          price: productModel.price,
                          textPrice: _quantityTextController.text,
                          isOnSale: productModel.isOnSale),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: FittedBox(
                              child: TextWidget(
                                text: productModel.isPiece ? 'Piece' : 'kg',
                                color: color,
                                textSize: 20,
                                isTilte: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              controller: _quantityTextController,
                              key: const ValueKey('10'),
                              style: TextStyle(color: color, fontSize: 18),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              onChanged: (value) {
                                setState(() {});
                              },
                              enabled: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _isInCart
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
                              prodId: productModel.id,
                              quantity: int.parse(_quantityTextController.text),
                              context: context);
                          // cartProvider.addProduct(
                          //   productId: productModel.id,
                          //   quantity: int.parse(
                          //     _quantityTextController.text,
                          //   ),
                          // );
                        },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      TextWidget(
                        text: _isInCart ? 'In cart' : 'Add to cart',
                        color: color,
                        textSize: 20,
                        maxLines: 1,
                      ),
                      const Spacer(),
                      Icon(
                        IconlyLight.buy,
                        color: color,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
