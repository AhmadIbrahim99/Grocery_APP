import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems => _cartItems;

  void addProduct({
    required String productId,
    required int quantity,
  }) =>
      _cartItems.putIfAbsent(
        productId,
        () => CartModel(
          id: DateTime.now().toString(),
          productsId: productId,
          quantity: quantity,
        ),
      );
}
