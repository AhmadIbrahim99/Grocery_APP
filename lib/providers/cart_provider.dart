import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/models/cart.dart';
import 'package:uuid/uuid.dart';

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

  Future<void> fetchCart() async {
    final User? user = firebaseAuth.currentUser;
    if (user == null) return;
    String _uid = user.uid;
    if (_uid.isEmpty) return;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      snapshot.get('userCart').forEach((element) {
        _cartItems.putIfAbsent(
            element['productId'],
            () => CartModel(
                id: element['cartId'],
                productsId: element['productId'],
                quantity: element['quantity']));
      });
    }).onError((error, stackTrace) {
      print(error);
    });

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
}
