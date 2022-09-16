import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/providers/wishlist_provider.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:provider/provider.dart';

class HeartButton extends StatefulWidget {
  HeartButton({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool isInWishlist;

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  final User? user = firebaseAuth.currentUser;
  bool _isLoding = false;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final _wishListProvider = Provider.of<WishListProvider>(context);
    final _currentProduct = Provider.of<ProductsProvider>(context)
        .getProductById(id: widget.productId);
    return GestureDetector(
      onTap: () async {
        if (user == null) {
          await GlobalMethods.errorDialog(
              function: () => GlobalMethods.navigateTo(
                  ctx: context, name: LoginScreen.routeName),
              title: 'Error',
              hintText: 'Plz login first',
              textButton: 'Ok',
              context: context);
          return;
        }
        setState(() {
          _isLoding = true;
        });
        if (widget.isInWishlist == false && widget.isInWishlist != null) {
          await GlobalMethods.addToWishlist(
              prodId: widget.productId, context: context);
        } else {
          await _wishListProvider.removeOneItem(
              wishListId:
                  _wishListProvider.getWishListItems[_currentProduct.id]!.id,
              productId: widget.productId);
        }
        await _wishListProvider.fetchWishList();

        setState(() {
          _isLoding = false;
        });
        // _wishListProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: _isLoding
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            )
          : Icon(
              widget.isInWishlist ? IconlyBold.heart : IconlyLight.heart,
              size: 21,
              color: widget.isInWishlist ? Colors.red : color,
            ),
    );
  }
}
