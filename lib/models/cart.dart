import 'package:flutter/cupertino.dart';

class CartModel with ChangeNotifier {
  final String id, productsId;
  final int quantity;

  CartModel({
    required this.id,
    required this.productsId,
    required this.quantity,
  });
}
