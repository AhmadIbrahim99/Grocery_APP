import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/wishlist.dart';

import '../consts/firebase_const.dart';

class WishListProvider with ChangeNotifier {
  Map<String, WishListModel> _WishListItems = {};

  Map<String, WishListModel> get getWishListItems => _WishListItems;
  final userCollection = FirebaseFirestore.instance.collection('users');

  // void addRemoveProductToWishlist({required String productId}) {
  //   if (_WishListItems.containsKey(productId)) {
  //     removeOneItem(productId);
  //   } else {
  //     _WishListItems.putIfAbsent(
  //         productId,
  //         () => WishListModel(
  //             id: DateTime.now().toString(), productsId: productId));
  //   }

  //   notifyListeners();
  // }
  Future<void> fetchWishList() async {
    final User? user = firebaseAuth.currentUser;

    String _uid = user!.uid;

    await userCollection.doc(_uid).get().then((DocumentSnapshot snapshot) {
      snapshot.get('userWish').forEach((element) {
        _WishListItems.putIfAbsent(
            element['productId'],
            () => WishListModel(
                id: element['wishlistId'], productsId: element['productId']));
      });
    }).onError((error, stackTrace) {
      print(error);
    });

    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String wishListId, required String productId}) async {
    final User? user = firebaseAuth.currentUser;

    await userCollection.doc(user!.uid).update({
      'userCart': FieldValue.arrayRemove([
        {'wishlistId': wishListId, 'productId': productId}
      ])
    });
    _WishListItems.remove(productId);
    await fetchWishList();
    notifyListeners();
  }

  Future<void> clearOnLineWishList() async {
    final User? user = firebaseAuth.currentUser;

    await userCollection
        .doc(user!.uid)
        .update({'userwish': FieldValue.arrayRemove([])});
    _WishListItems.clear();
    notifyListeners();
  }

  void clearLocalWishList() {
    _WishListItems.clear();
    notifyListeners();
  }
  // void removeOneItem(String productId) {
  //   _WishListItems.remove(productId);
  //   notifyListeners();
  // }

  // void clearWishList() {
  //   _WishListItems.clear();
  //   notifyListeners();
  // }
}
