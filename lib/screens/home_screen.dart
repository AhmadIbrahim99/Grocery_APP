import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> __offerImages = [
    "assets/images/offers/Offer1.jpg",
    "assets/images/offers/Offer2.jpg",
    "assets/images/offers/Offer3.jpg",
    "assets/images/offers/Offer4.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    Size size = utils.getScreenSize;
    final themState = utils.getThem;
    return Scaffold(
      body: SizedBox(
          height: size.height * 0.33,
          child: Swiper(
            itemBuilder: (context, index) => Image.asset(
              __offerImages[index],
              fit: BoxFit.fill,
            ),
            autoplay: true,
            itemCount: __offerImages.length,
            pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                  color: Colors.white, activeColor: Colors.red),
            ),
            // control: const SwiperControl(color: Colors.black),
          )),
    );
  }
}
