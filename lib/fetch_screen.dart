import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/consts/constss.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/providers/wishlist_provider.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:provider/provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);
  static const String routeName = "FetchScreen";

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishListProvider =
          Provider.of<WishListProvider>(context, listen: false);
      final User? user = firebaseAuth.currentUser;
      await productsProvider.fetchProductData();
      if (user != null) {
        await cartProvider.fetchCart();
        await wishListProvider.fetchWishList();
      } else {
        cartProvider.clearLocalCart();
        wishListProvider.clearLocalWishList();
      }
      GlobalMethods.navigateReplacementTo(
          ctx: context, name: BottomBarScreen.routeName);
    });
    super.initState();
  }

  List<String> images = Constss.imgPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          images[Random().nextInt(images.length)],
          fit: BoxFit.cover,
          height: double.infinity,
        ),
        Container(
          color: Colors.black.withOpacity(0.7),
        ),
        const Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
          ),
        )
      ]),
    );
  }
}
