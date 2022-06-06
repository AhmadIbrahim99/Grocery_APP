import 'package:flutter/material.dart';
import 'package:grocery_app/consts/theme_data.dart';
import 'package:grocery_app/inner_screens/feeds_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/Home_Screen.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/screens/order/orders_screen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:grocery_app/screens/whishlist/whishlist_screen.dart';
import 'package:provider/provider.dart';

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
      providers: [ChangeNotifierProvider(create: (_) => themeChangeProvicer)],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Grocery',
            theme: Styels.themeData(themeProvider.getDarkTheme, context),
            home: const LoginScreen(),
            routes: {
              OnSaleScreen.routeName: (context) => const OnSaleScreen(),
              FeedsScreen.routeName: (context) => const FeedsScreen(),
              ProductDetailScreen.routeName: (context) =>
                  const ProductDetailScreen(),
              WhishListScreen.routeName: (context) => const WhishListScreen(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
              ViewedRecentlyScreen.roteName: (context) =>
                  const ViewedRecentlyScreen(),
            },
          );
        },
      ),
    );
  }
}
