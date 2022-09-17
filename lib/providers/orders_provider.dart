import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/models/orders_model.dart';

class OrderProvider with ChangeNotifier {
  static List<OrderModel> ordersList = [];
  List<OrderModel> get getOrders {
    return ordersList;
  }

  Future<void> fetchorderData() async {
    await FirebaseFirestore.instance.collection('orders').get().then((value) {
      ordersList.clear();
      value.docs.forEach((element) {
        ordersList.insert(
            0,
            OrderModel(
                userId: element.get('userId'),
                orderId: element.get('orderId'),
                imageUrl: element.get('imageUrl'),
                productId: element.get('productId'),
                price: element.get('price'),
                orderDate: element.get('orderDate'),
                quantity: element.get('quantity'),
                userName: element.get('userName')));
      });
    });
    notifyListeners();
  }

  OrderModel getorderById({required String id}) =>
      ordersList.firstWhere((element) => element.orderId == id);

  List<OrderModel> findByUserId(String userId) => ordersList
      .where((element) => element.userId
          .toLowerCase()
          .trim()
          .contains(userId.toLowerCase().trim()))
      .toList();

  List<OrderModel> searchQuery(String userName) => ordersList
      .where(
        (element) => element.userName.toLowerCase().contains(
              userName.toLowerCase().trim(),
            ),
      )
      .toList();
}
