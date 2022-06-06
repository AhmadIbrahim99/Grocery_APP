import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grocery_app/screens/auth/register.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/auth_button.dart';
import 'package:grocery_app/widgets/google_button.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../../consts/constss.dart';
import '../btm_bar.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocus = FocusNode();
  final _formkey = GlobalKey<FormState>();
  var _obscureText = true;
  @override
  void dispose() {
    _emailTextController.dispose();
    _passFocus.dispose();
    _passTextController.dispose();
    super.dispose();
  }

  void _submitFormOnLogin() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) log("isValid YAY");
  }

  validatorEmail(String? value) {
    if (value!.isEmpty || !value.contains('@') || value.length < 7)
      return 'please enter a valid email Adress';

    return null;
  }

  validatorPass(String? value) {
    if (value!.isEmpty || value.length < 7)
      return 'please enter a valid password';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).getColor;
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            duration: 800, // 0.8 sec
            autoplayDelay: 6000, //6 sec
            itemBuilder: (context, index) => Image.asset(
              Constss.imgPath[index],
              fit: BoxFit.fill,
            ),
            autoplay: true,
            itemCount: Constss.imgPath.length,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: size.height * 0.15,
                  ),
                  TextWidget(
                    text: 'WelCome Back',
                    color: Colors.white,
                    textSize: 30,
                    isTilte: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    text: "Sign in to continue",
                    color: Colors.white,
                    textSize: 18,
                    isTilte: false,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_passFocus),
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validatorEmail(value),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => _submitFormOnLogin(),
                          controller: _passTextController,
                          focusNode: _passFocus,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => validatorPass(value),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _obscureText = !_obscureText),
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'PassWord',
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () => GlobalMethods.navigateTo(
                          ctx: context, name: ForgetPasswordScreen.routeName),
                      child: const Text(
                        'Forget Password',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthButton(
                      fct: () => GlobalMethods.navigateTo(
                            ctx: context,
                            name: BottomBarScreen.routeName,
                          ),
                      buttonText: 'Login'),
                  const SizedBox(
                    height: 10,
                  ),
                  const GoogleButton(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextWidget(
                        text: 'OR',
                        color: Colors.white,
                        textSize: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthButton(
                    fct: () {},
                    buttonText: 'Continue as a guest',
                    primary: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account?!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                            text: '  Sign up',
                            style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => GlobalMethods.navigateTo(
                                  ctx: context,
                                  name: RegisterScreen.routeName)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
