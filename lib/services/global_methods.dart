import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:uuid/uuid.dart';

import '../widgets/text_widget.dart';

class GlobalMethods {
  static navigateTo({required ctx, required name, arguments}) {
    Navigator.pushNamed(ctx, name, arguments: arguments);
  }

  static navigateReplacementTo({required ctx, required name, arguments}) {
    Navigator.pushReplacementNamed(ctx, name, arguments: arguments);
  }

  static Future<void> warningDialog(
      {required function,
      required title,
      required hintText,
      required textButton,
      required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(title)
              ],
            ),
            content: Text(hintText),
            actions: [
              TextButton(
                onPressed: () {
                  if (!Navigator.canPop(context)) return;

                  Navigator.pop(context);
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: "Cancel",
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  function();
                  if (!Navigator.canPop(context)) return;
                  Navigator.pop(context);
                },
                child: TextWidget(
                  color: Colors.red,
                  text: textButton,
                  textSize: 18,
                ),
              )
            ],
          );
        });
  }

  static Future<void> errorDialog(
      {required function,
      required title,
      required hintText,
      required textButton,
      required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(title)
              ],
            ),
            content: Text(hintText),
            actions: [
              TextButton(
                onPressed: () {
                  if (!Navigator.canPop(context)) return;

                  Navigator.pop(context);
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: "Cancel",
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (!Navigator.canPop(context)) return;
                  Navigator.pop(context);
                  function();
                },
                child: TextWidget(
                  color: Colors.red,
                  text: textButton,
                  textSize: 18,
                ),
              )
            ],
          );
        });
  }

  static Future<void> addToCart({
    required String prodId,
    required int quantity,
    required BuildContext context,
  }) async {
    final User? user = firebaseAuth.currentUser;
    final _uid = user!.uid;
    final catId = const Uuid().v4();
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userCart': FieldValue.arrayUnion([
        {
          'cartId': catId,
          'productId': prodId,
          'quantity': quantity,
        }
      ])
    }).then((value) async {
      await Fluttertoast.showToast(msg: "Item has been added to you'r cart");
    }).onError((error, stackTrace) {
      errorDialog(
          function: () {},
          title: 'Error',
          hintText: '$error',
          textButton: 'Ok',
          context: context);
    });
  }

  static Future<void> addToWishlist({
    required String prodId,
    required BuildContext context,
  }) async {
    final User? user = firebaseAuth.currentUser;
    final _uid = user!.uid;
    final wishlistId = const Uuid().v4();
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userWish': FieldValue.arrayUnion([
        {
          'wishlistId': wishlistId,
          'productId': prodId,
        }
      ])
    }).then((value) async {
      await Fluttertoast.showToast(
          msg: "Item has been added to you'r wishlist");
    }).onError((error, stackTrace) {
      errorDialog(
          function: () {},
          title: 'Error',
          hintText: '$error',
          textButton: 'Ok',
          context: context);
    });
  }
}
