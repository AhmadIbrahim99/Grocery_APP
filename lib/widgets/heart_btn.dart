import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/providers/wishlist_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:provider/provider.dart';

class HeartButton extends StatelessWidget {
  const HeartButton(
      {Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool isInWishlist;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final _wishListProvider = Provider.of<WishListProvider>(context);
    return GestureDetector(
      onTap: () =>
          _wishListProvider.addRemoveProductToWishlist(productId: productId),
      child: Icon(
        isInWishlist ? IconlyBold.heart : IconlyLight.heart,
        size: 21,
        color: isInWishlist ? Colors.red : color,
      ),
    );
  }
}
