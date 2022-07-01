import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/products.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/on_sale_widget.dart';
import 'package:grocery_app/widgets/prd_empty.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    final proudctsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> products = proudctsProvider.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () => Navigator.pop(context),
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Products on sale",
          color: color,
          textSize: 24.0,
          isTilte: true,
        ),
      ),
      body: products.isEmpty
          ? const EmptyProduct(text: "No products on sale yet!, \n Stay tuned")
          : GridView.count(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              childAspectRatio: size.width / (size.height * 0.45),
              children: List.generate(
                  products.length,
                  (index) => ChangeNotifierProvider.value(
                      value: products[index], child: const OnSaleWidget())),
            ),
    );
  }
}
