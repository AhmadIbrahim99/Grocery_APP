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

  final userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> fetchCart() async {
    final User? user = firebaseAuth.currentUser;

    String _uid = user!.uid;

    await userCollection.doc(_uid).get().then((DocumentSnapshot snapshot) {
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

  Future<void> removeOneItem(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    final User? user = firebaseAuth.currentUser;

    await userCollection.doc(user!.uid).update({
      'userCart': FieldValue.arrayRemove([
        {'cartId': cartId, 'productId': productId, 'quantity': quantity}
      ])
    });
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearOnLineCart() async {
    final User? user = firebaseAuth.currentUser;

    await userCollection
        .doc(user!.uid)
        .update({'userCart': FieldValue.arrayRemove([])});
    _cartItems.clear();
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
