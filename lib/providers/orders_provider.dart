import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/orders_model.dart';

class OrderProvider with ChangeNotifier {
  static List<OrderModel> ordersList = [];
  List<OrderModel> get getOrders {
    return ordersList;
  }
}
