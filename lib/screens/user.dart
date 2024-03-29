import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/providers/dark_theme_provider.dart';
import 'package:grocery_app/screens/auth/forget_password.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/screens/order/orders_screen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:grocery_app/screens/whishlist/whishlist_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../widgets/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  final User? user = firebaseAuth.currentUser;
  @override
  initState() {
    _getUserInfo();
    super.initState();
  }

  bool _isLoading = false;
  String? _email;
  String? _name;
  String? _address;
  Future<void> _getUserInfo() async {
    if (user == null) return;
    setState(() {
      _isLoading = true;
    });
    String _uid = user!.uid;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .get()
        .then((value) {
      _email = value.get('email') ?? "Email";
      _name = value.get('name') ?? "You'r Name";
      _address = value.get('shipping-address') ?? 'No Address';
      _addressController.text = _address ?? 'No Address';
    }).then((value) {
      setState(() {
        _isLoading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _isLoading = false;
      });
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themState = Provider.of<DarkThemeProvider>(context);
    final Color color = themState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Hi, ",
                      style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 27,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: _name ?? "",
                            style: TextStyle(
                              color: color,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print("My Name Is pressed")),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    color: color,
                    text: _email ?? "",
                    textSize: 17,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  _listTiles(
                    color: color,
                    title: "Address",
                    subTitle: _address ?? "",
                    icon: IconlyLight.profile,
                    onPressed: () => _showDialog(
                        title: "Update",
                        hintText: _address ?? "",
                        textButton: "Update"),
                  ),
                  _listTiles(
                    color: color,
                    title: "Orders",
                    icon: IconlyLight.bag,
                    onPressed: () => GlobalMethods.navigateTo(
                        ctx: context, name: OrdersScreen.routeName),
                  ),
                  _listTiles(
                    color: color,
                    title: "Whishlist",
                    icon: IconlyLight.heart,
                    onPressed: () => GlobalMethods.navigateTo(
                        ctx: context, name: WhishListScreen.routeName),
                  ),
                  _listTiles(
                    color: color,
                    title: "Viewed",
                    icon: IconlyLight.show,
                    onPressed: () => GlobalMethods.navigateTo(
                        ctx: context, name: ViewedRecentlyScreen.roteName),
                  ),
                  _listTiles(
                      color: color,
                      title: "Forget Password",
                      icon: IconlyLight.unlock,
                      onPressed: () => GlobalMethods.navigateTo(
                            ctx: context,
                            name: ForgetPasswordScreen.routeName,
                          )),
                  SwitchListTile(
                    title: TextWidget(
                      color: color,
                      text: themState.getDarkTheme ? "Dark Mode" : "Light Mode",
                      textSize: 22,
                      isTilte: true,
                    ),
                    secondary: Icon(themState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
                    onChanged: (bool value) {
                      setState(() {
                        themState.setDarkTheme = value;
                      });
                    },
                    value: themState.getDarkTheme,
                  ),
                  _listTiles(
                      color: color,
                      title: user == null ? "Login" : "Logout",
                      icon: IconlyLight.logout,
                      onPressed: user == null
                          ? () => GlobalMethods.navigateTo(
                                ctx: context,
                                name: LoginScreen.routeName,
                              )
                          : () => GlobalMethods.warningDialog(
                              function: () async {
                                await GoogleSignIn().isSignedIn()
                                    ? await GoogleSignIn().signOut()
                                    : () {};
                                await firebaseAuth.signOut().then((value) =>
                                    GlobalMethods.navigateTo(
                                        ctx: context,
                                        name: LoginScreen.routeName));
                              },
                              context: context,
                              hintText: "Are you sure you wanna leave Us ??!",
                              textButton: "Yes",
                              title: "Sign out")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog(
      {required title, required hintText, required textButton}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              controller: _addressController,
              onChanged: (value) {},
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(hintText: hintText),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String _uid = user!.uid;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_uid)
                      .update({
                    'shipping-address': _addressController.text,
                  }).then((value) {
                    Navigator.pop(context);
                    setState(() {
                      _address = _addressController.text;
                    });
                  });
                },
                child: Text(textButton),
              )
            ],
          );
        });
  }
}

Widget _listTiles(
        {required String title,
        String? subTitle,
        required IconData icon,
        required Function onPressed,
        required Color color}) =>
    ListTile(
      title: TextWidget(
        color: color,
        text: title,
        textSize: 22,
        isTilte: true,
      ),
      subtitle: TextWidget(
        color: color,
        text: subTitle ?? '',
        textSize: 16,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () => onPressed(),
    );
