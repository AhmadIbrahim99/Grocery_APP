import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/wishlist.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/heart_btn.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/wishlist_provider.dart';

class WhishlistWidget extends StatelessWidget {
  const WhishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishListModel = Provider.of<WishListModel>(context);
    final getProduct =
        productProvider.getProductById(id: wishListModel.productsId);
    double userPrice =
        getProduct.isOnSale ? getProduct.salePrice : getProduct.price;
    final wishListProvider = Provider.of<WishListProvider>(context);
    bool isInWishList =
        wishListProvider.getWishListItems.containsKey(getProduct.id);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => GlobalMethods.navigateTo(
            ctx: context,
            name: ProductDetailScreen.routeName,
            arguments: getProduct.id),
        child: Container(
          height: size.height * 0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  // width: size.width * 0.2,
                  height: size.width * 0.25,
                  child: FancyShimmerImage(
                    imageUrl: getProduct.imageUrl,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconlyLight.bag2,
                              color: color,
                            ),
                          ),
                          HeartButton(
                            productId: getProduct.id,
                            isInWishlist: isInWishList,
                          ),
                        ],
                      ),
                    ),
                    TextWidget(
                      text: getProduct.title,
                      color: color,
                      textSize: 19.0,
                      maxLines: 2,
                      isTilte: true,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextWidget(
                      text: '\$${userPrice.toStringAsFixed(2)}',
                      color: color,
                      textSize: 17.0,
                      maxLines: 1,
                      isTilte: true,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
