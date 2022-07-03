import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/products.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/providers/viewed_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../providers/wishlist_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = "/ProductDetailScreen";
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _qTEC = TextEditingController(text: '1');

  @override
  void dispose() {
    _qTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final prdoctsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    ProductModel productModel = prdoctsProvider.getProductById(id: productId);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    double userPrice =
        productModel.isOnSale ? productModel.salePrice : productModel.price;
    _qTEC.text = _isInCart
        ? cartProvider.getCartItems.values
            .firstWhere((element) => element.productsId == productModel.id)
            .quantity
            .toString()
        : "1";
    double? totalPrice = userPrice * int.parse(_qTEC.text);
    final _wishListProvider = Provider.of<WishListProvider>(context);
    bool? _isInWishList =
        _wishListProvider.getWishListItems.containsKey(productModel.id);
    final viewedProvider = Provider.of<ViewedProductProvider>(context);
    return WillPopScope(
      onWillPop: () async =>
          viewedProvider.addToViewedProduct(productId: productModel.id),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                // height: size.width * 0.21,
                width: size.width,
                boxFit: BoxFit.scaleDown,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 21, left: 31, right: 31),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWidget(
                              text: productModel.title,
                              color: color,
                              textSize: 25,
                              isTilte: true,
                            ),
                          ),
                          HeartButton(
                            productId: productModel.id,
                            isInWishlist: _isInWishList,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 21, left: 31, right: 31),
                      child: Row(
                        children: [
                          TextWidget(
                            text: '\$${userPrice.toStringAsFixed(2)}/',
                            color: Colors.green,
                            textSize: 22,
                            isTilte: true,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          TextWidget(
                            text: productModel.isPiece ? 'Piece' : '/Kg',
                            color: color,
                            textSize: 16,
                            isTilte: false,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: productModel.isOnSale,
                            child: Text(
                              '\$${productModel.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 15,
                                color: color,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(
                                63,
                                200,
                                101,
                                1,
                              ),
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                            ),
                            child: TextWidget(
                              text: 'Free delivery',
                              color: Colors.white,
                              textSize: 20,
                              isTilte: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _quantityController(
                          fct: () {
                            if (_qTEC.text == "1") return;

                            setState(() {
                              _qTEC.text =
                                  (int.parse(_qTEC.text) - 1).toString();
                            });
                          },
                          icon: CupertinoIcons.minus,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: _qTEC,
                            key: const ValueKey('quantity'),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            cursorColor: Colors.green,
                            enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                            ],
                            onChanged: (v) => onChange(v),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        _quantityController(
                          fct: () {
                            setState(() {
                              _qTEC.text =
                                  (int.parse(_qTEC.text) + 1).toString();
                            });
                          },
                          icon: CupertinoIcons.plus,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 21, horizontal: 31),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: 'Total',
                                  color: Colors.red.shade300,
                                  textSize: 20,
                                  isTilte: true,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text:
                                            '\$${totalPrice.toStringAsFixed(2)}/',
                                        color: color,
                                        textSize: 20,
                                        isTilte: true,
                                      ),
                                      TextWidget(
                                        text:
                                            '${_qTEC.text}${productModel.isPiece ? 'Piece' : 'Kg'}',
                                        color: color,
                                        textSize: 16,
                                        isTilte: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                              child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () => _isInCart
                                    ? null
                                    : cartProvider.addProduct(
                                        productId: productModel.id,
                                        quantity: int.parse(_qTEC.text)),
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    12.0,
                                  ),
                                  child: TextWidget(
                                      text:
                                          _isInCart ? 'In cart' : 'Add to cart',
                                      color: Colors.white,
                                      textSize: 18),
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                padding: const EdgeInsets.all(8.0),
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

  onChange(value) {
    if (value.isNotEmpty) return;
    _qTEC.text = '1';
  }
}
