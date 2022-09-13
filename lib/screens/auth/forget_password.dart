import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/auth_button.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../consts/constss.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = "/ForgetPasswordScreen";

  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();

  validatorEmail(String? value) {
    if (value!.isEmpty || !value.contains('@') || value.length < 7)
      return 'please enter a valid email Adress';

    return null;
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains("@")) {
      _isLoading = false;
      GlobalMethods.warningDialog(
          function: () {},
          title: "Email",
          hintText: "Wrong Email",
          textButton: "Ok",
          context: context);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    await firebaseAuth
        .sendPasswordResetEmail(email: _emailTextController.text.toLowerCase())
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
          textColor: Colors.white,
          backgroundColor: Colors.grey.shade400,
          msg:
              "An email has been sent to ur email address plz check ur email inbox or unwanted");
    }).onError((error, stackTrace) {
      setState(() {
        _isLoading = false;
      });

      GlobalMethods.errorDialog(
          function: () {},
          title: "Email",
          hintText: "Some Thing Went Wrong",
          textButton: "Ok",
          context: context);
    });
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final theme = Utils(context).getThem;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemCount: Constss.imgPath.length,
              duration: 800,
              autoplayDelay: 6000,
              autoplay: true,
              itemBuilder: (c, i) => Image.asset(
                Constss.imgPath[i],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60.0,
                  ),
                  const BackWidget(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextWidget(
                    text: 'Forget password',
                    color: Colors.white,
                    textSize: 30,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                      fct: () => _forgetPassFCT(), buttonText: 'Reset now')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
