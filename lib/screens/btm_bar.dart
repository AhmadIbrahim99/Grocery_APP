import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/categories.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/user.dart';
import 'package:provider/provider.dart';

import 'cart/cart_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pageList = [
    {'page': const HomeScreen(), 'title': 'Home'},
    {'page': CategoriesScreen(), 'title': 'Categories'},
    {'page': const CartScreen(), 'title': 'Cart'},
    {'page': const UserScreen(), 'title': 'User'}
  ];

  void _selectedIndexPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_pageList[_selectedIndex]['title']),
      // ),
      body: _pageList[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed, //stop Shifted
        unselectedItemColor: _isDark ? Colors.white10 : Colors.black12,
        selectedItemColor: _isDark ? Colors.lightBlue.shade200 : Colors.black87,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _selectedIndexPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? const Icon(IconlyBold.home)
                  : const Icon(IconlyLight.home),
              label: "Home"),
          BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? const Icon(IconlyBold.category)
                  : const Icon(IconlyLight.category),
              label: "Category"),
          BottomNavigationBarItem(
              icon: Badge(
                toAnimate: true,
                shape: BadgeShape.circle,
                badgeColor: Colors.blue,
                borderRadius: BorderRadius.circular(8),
                // position: BadgePosition.topEnd(top: -7, end: -7),
                badgeContent: const FittedBox(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Icon(
                  _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
                ),
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? const Icon(IconlyBold.user2)
                  : const Icon(IconlyLight.user2),
              label: "User"),
        ],
      ),
    );
  }
}
