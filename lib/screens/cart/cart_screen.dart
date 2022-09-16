import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/screens/cart/cart_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();

    return cartItemsList.isEmpty
        ? const EmptyScreen(
            buttonText: 'Shop Now',
            imgPath: 'assets/images/cart.png',
            subTitle: 'Add some Thing',
            title: 'Your cart is Empty',
          )
        : Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                title: TextWidget(
                  text: 'Cart (${cartItemsList.length})',
                  color: color,
                  textSize: 22,
                  isTilte: true,
                ),
                actions: [
                  IconButton(
                      onPressed: () => GlobalMethods.warningDialog(
                          function: () async {
                            await cartProvider.clearOnLineCart();
                            cartProvider.clearLocalCart();
                          },
                          title: 'Empty your cart?!',
                          hintText: 'Are you sure?!!',
                          textButton: 'yes',
                          context: context),
                      color: color,
                      icon: const Icon(IconlyLight.delete))
                ]),
            body: Column(
              children: [
                _checkOut(
                    context: context,
                    size: size,
                    color: color,
                    cartProvider: cartProvider,
                    productsProvider: productProvider),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItemsList.length,
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider.value(
                            value: cartItemsList[index],
                            child:
                                CartWidget(q: cartItemsList[index].quantity)),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _checkOut(
      {required BuildContext context,
      required Size size,
      required Color color,
      required CartProvider cartProvider,
      required ProductsProvider productsProvider}) {
    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrent = productsProvider.getProductById(id: value.productsId);
      total += (getCurrent.isOnSale ? getCurrent.salePrice : getCurrent.price) *
          value.quantity;
    });
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Row(
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: 'Order Now',
                    color: Colors.white,
                    textSize: 20,
                  ),
                ),
              ),
            ),
            const Spacer(),
            FittedBox(
              child: TextWidget(
                text: 'Total: \$${total}',
                color: color,
                textSize: 17,
                isTilte: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
