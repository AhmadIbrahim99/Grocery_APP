import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/consts/constss.dart';
import 'package:grocery_app/consts/firebase_const.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import '../../services/global_methods.dart';
import '../../widgets/auth_button.dart';
import 'forget_password.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = "/RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();

  final _fullNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _addressFocus = FocusNode();

  var _obscureText = true;
  @override
  void dispose() {
    _fullNameTextController.dispose();
    _emailTextController.dispose();
    _addressTextController.dispose();
    _passTextController.dispose();
    _passFocus.dispose();
    _emailFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormForRegister() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) return;
    setState(() {
      _isLoading = true;
    });
    _formkey.currentState!.save();
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim())
        .then((value) async {
      final User? user = firebaseAuth.currentUser;

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'id': user.uid,
        'name': _fullNameTextController.text,
        'email': _emailTextController.text.toLowerCase(),
        'shipping-address': _addressTextController.text,
        'userWish': [],
        'userCart': [],
        'createdAt': Timestamp.now(),
      });

      setState(() {
        _isLoading = false;
      });

      GlobalMethods.navigateReplacementTo(
          ctx: context, name: BottomBarScreen.routeName);
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(
          function: () {},
          title: 'Error Sign Up',
          hintText: '${error.message}',
          textButton: "Ok",
          context: context);
    });
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

  validatorFullName(String? value) {
    if (value!.isEmpty || value.length < 5)
      return 'please enter a valid Full Name';

    return null;
  }

  validatorAddress(String? value) {
    if (value!.isEmpty || value.length < 5)
      return 'please enter a valid Address';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 60.0,
                    ),
                    const BackWidget(),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextWidget(
                      text: 'Welcome',
                      color: Colors.white,
                      textSize: 30,
                      isTilte: true,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextWidget(
                      text: 'Sign up to continue',
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
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocus),
                            keyboardType: TextInputType.name,
                            controller: _fullNameTextController,
                            validator: (value) => validatorFullName(value),
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Full Name',
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
                            height: 20,
                          ),
                          TextFormField(
                            focusNode: _emailFocus,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(_passFocus),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextController,
                            validator: (value) => validatorEmail(value),
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
                            height: 20,
                          ),
                          TextFormField(
                            focusNode: _passFocus,
                            obscureText: _obscureText,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_addressFocus),
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passTextController,
                            validator: (value) => validatorPass(value),
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                  onPressed: () => setState(
                                      () => _obscureText = !_obscureText),
                                  icon: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            focusNode: _addressFocus,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: _submitFormForRegister,
                            keyboardType: TextInputType.streetAddress,
                            controller: _addressTextController,
                            validator: (value) => validatorAddress(value),
                            style: const TextStyle(color: Colors.white),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            decoration: const InputDecoration(
                              hintText: 'Shipping address',
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => GlobalMethods.navigateTo(
                            ctx: context, name: ForgetPasswordScreen.routeName),
                        child: const Text(
                          'Forget Password?',
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
                        fct: _submitFormForRegister, buttonText: 'Sign up'),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Already a user?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: '  Sign in',
                            style: const TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
