import 'package:flutter/cupertino.dart';

import '../models/viewed.dart';

class ViewedProductProvider with ChangeNotifier {
  Map<String, ViewedProductModel> viewedProductItems = {};

  Map<String, ViewedProductModel> get getViewedProductItems =>
      viewedProductItems;
  bool addToViewedProduct({required String productId}) {
    viewedProductItems.putIfAbsent(
        productId,
        () => ViewedProductModel(
            id: DateTime.now().toString(), productId: productId));
    notifyListeners();
    return true;
  }

  void clearHistory() {
    viewedProductItems.clear();
    notifyListeners();
  }
}
