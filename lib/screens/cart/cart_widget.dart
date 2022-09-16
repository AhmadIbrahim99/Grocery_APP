import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/products.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.q}) : super(key: key);
  final int q;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = widget.q.toString();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final carttModel = Provider.of<CartModel>(context);
    ProductModel getCurrentProduct =
        productsProvider.getProductById(id: carttModel.productsId);
    double userPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    final _wishListProvider = Provider.of<WishListProvider>(context);
    bool _isInWishList =
        _wishListProvider.getWishListItems.containsKey(getCurrentProduct.id);
    return GestureDetector(
      onTap: () => GlobalMethods.navigateTo(
          ctx: context,
          name: ProductDetailScreen.routeName,
          arguments: carttModel.productsId),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.15,
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.imageUrl,
                        height: size.width * 0.21,
                        width: size.width * 0.21,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: getCurrentProduct.title,
                          color: color,
                          textSize: 19,
                          isTilte: true,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                            children: [
                              _quantityController(
                                  fct: () {
                                    if (_quantityTextController.text == "1")
                                      return;
                                    cartProvider.reduceQuantityByOne(
                                        carttModel.productsId);
                                    setState(() {
                                      _quantityTextController.text = (int.parse(
                                                  _quantityTextController
                                                      .text) -
                                              1)
                                          .toString();
                                    });
                                  },
                                  color: Colors.red,
                                  icon: CupertinoIcons.minus),
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(),
                                    ),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (v) => onChange(v),
                                ),
                              ),
                              _quantityController(
                                  fct: () {
                                    cartProvider.addQuantityByOne(
                                        carttModel.productsId);
                                    setState(() {
                                      _quantityTextController.text = (int.parse(
                                                  _quantityTextController
                                                      .text) +
                                              1)
                                          .toString();
                                    });
                                  },
                                  color: Colors.green,
                                  icon: CupertinoIcons.plus),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async => await cartProvider.removeOneItem(
                                cartId: carttModel.id,
                                productId: carttModel.productsId,
                                quantity: carttModel.quantity),
                            child: const Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          HeartButton(
                            productId: getCurrentProduct.id,
                            isInWishlist: _isInWishList,
                          ),
                          TextWidget(
                            text:
                                '\$${(userPrice * int.parse(_quantityTextController.text)).toStringAsFixed(2)}',
                            color: color,
                            textSize: 18,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onChange(value) {
    if (value.isNotEmpty) return;
    _quantityTextController.text = '1';
  }

  Widget _quantityController(
          {required Function fct,
          required IconData icon,
          required Color color}) =>
      Flexible(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Material(
            color: color,
            borderRadius: BorderRadius.circular(
              12,
            ),
            child: InkWell(
              onTap: () => fct(),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      );
}
