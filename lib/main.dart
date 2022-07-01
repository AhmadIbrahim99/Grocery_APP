import 'package:flutter/material.dart';
import 'package:grocery_app/consts/theme_data.dart';
import 'package:grocery_app/inner_screens/feeds_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/screens/Home_Screen.dart';
import 'package:grocery_app/screens/auth/forget_password.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/auth/register.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/screens/order/orders_screen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:grocery_app/screens/whishlist/whishlist_screen.dart';
import 'package:provider/provider.dart';

import 'inner_screens/cat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvicer = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvicer.setDarkTheme =
        await themeChangeProvicer.darkThemPrefs.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => themeChangeProvicer,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grocery',
            theme: Styels.themeData(themeProvider.getDarkTheme, context),
            home: const BottomBarScreen(),
            routes: {
              BottomBarScreen.routeName: (context) => const BottomBarScreen(),
              OnSaleScreen.routeName: (context) => const OnSaleScreen(),
              FeedsScreen.routeName: (context) => const FeedsScreen(),
              ProductDetailScreen.routeName: (context) =>
                  const ProductDetailScreen(),
              WhishListScreen.routeName: (context) => const WhishListScreen(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
              ViewedRecentlyScreen.roteName: (context) =>
                  const ViewedRecentlyScreen(),
              RegisterScreen.routeName: (context) => const RegisterScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              ForgetPasswordScreen.routeName: (context) =>
                  const ForgetPasswordScreen(),
              CategoryScreen.routeName: (context) => const CategoryScreen(),
            },
          );
        },
      ),
    );
  }
}
