import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount == null) return;
    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;

    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      GlobalMethods.warningDialog(
          function: () {},
          title: "Error",
          hintText: "Some Thing Went Wrong",
          textButton: "Ok",
          context: context);
      return;
    }

    await firebaseAuth
        .signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken))
        .then((value) {
      GlobalMethods.navigateTo(ctx: context, name: BottomBarScreen.routeName);
    }).onError((error, stackTrace) {
      GlobalMethods.errorDialog(
          function: () {},
          title: 'Error',
          hintText: '$error',
          textButton: 'Ok',
          context: context);
    });

    // final UserCredential userCredential =
    //     await firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
    //         idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
    // if (userCredential.credential == null) return;

    // GlobalMethods.navigateTo(ctx: context, name: const BottomBarScreen());
    //     .then((result) {
    //   GlobalMethods.navigateTo(ctx: context, name: const BottomBarScreen());
    // }).catchError((onError) {
    //   GlobalMethods.errorDialog(
    //       function: () {},
    //       title: '$onError',
    //       hintText: '${onError}',
    //       textButton: 'Ok',
    //       context: context);
    // });
  }

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.blue,
        child: InkWell(
          onTap: () {
            _googleSignIn(context);
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              color: Colors.white,
              child: Image.asset(
                'assets/images/google.png',
                width: 40.0,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            TextWidget(
                text: 'Sign in with Google', color: Colors.white, textSize: 18),
          ]),
        ),
      );
}
