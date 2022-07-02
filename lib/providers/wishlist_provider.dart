import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/wishlist.dart';

class WishListProvider with ChangeNotifier {
  Map<String, WishListModel> _WishListItems = {};

  Map<String, WishListModel> get getWishListItems => _WishListItems;
  void addRemoveProductToWishlist({required String productId}) {
    if (_WishListItems.containsKey(productId)) {
      removeOneItem(productId);
    } else {
      _WishListItems.putIfAbsent(
          productId,
          () => WishListModel(
              id: DateTime.now().toString(), productsId: productId));
    }

    notifyListeners();
  }

  void removeOneItem(String productId) {
    _WishListItems.remove(productId);
    notifyListeners();
  }

  void clearWishList() {
    _WishListItems.clear();
    notifyListeners();
  }
}
