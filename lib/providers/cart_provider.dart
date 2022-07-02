import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems => _cartItems;

  void addProduct({
    required String productId,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(
        id: DateTime.now().toString(),
        productsId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
          id: value.id, productsId: productId, quantity: value.quantity - 1),
    );
    notifyListeners();
  }

  void addQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
          id: value.id, productsId: productId, quantity: value.quantity + 1),
    );
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int getItemsCount() {
    notifyListeners();
    return _cartItems.length;
  }
}
