import 'package:flutter/cupertino.dart';

class WishListModel with ChangeNotifier {
  final String id, productsId;

  WishListModel({
    required this.id,
    required this.productsId,
  });
}
