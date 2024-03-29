import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/consts/constss.dart';
import 'package:grocery_app/models/products.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/feed_items_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/prd_empty.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "CategoryScreen";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focus = FocusNode();
  List<ProductModel> listProductsSearch = [];
  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    Color color = Utils(context).getColor;
    Size size = Utils(context).getScreenSize;
    final categorName = ModalRoute.of(context)!.settings.arguments as String;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> products = productsProvider.findByCategory(categorName);
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
          text: categorName,
          color: color,
          textSize: 24.0,
          isTilte: true,
        ),
        centerTitle: true,
      ),
      body: products.isEmpty
          ? const EmptyProduct(
              text: "No products belong to this category yet!, \n Stay tuned")
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextField(
                        focusNode: _focus,
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            listProductsSearch =
                                productsProvider.searchQuery(value);
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            borderSide: const BorderSide(
                              color: Colors.greenAccent,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            borderSide: const BorderSide(
                              color: Colors.greenAccent,
                              width: 1,
                            ),
                          ),
                          hintText: "What is in you'r mind",
                          prefixIcon: const Icon(
                            IconlyLight.search,
                          ),
                          suffix: IconButton(
                            onPressed: () {
                              _searchController.clear();
                              _focus.unfocus();
                            },
                            icon: Icon(
                              Icons.close,
                              color: _focus.hasFocus ? Colors.red : color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  listProductsSearch.isEmpty &&
                          _searchController.text.trim().isNotEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/box.png",
                                  scale: 1.5,
                                ),
                                Text(
                                  "No products yet!, \n Stay tuned",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          crossAxisCount: 2,
                          childAspectRatio: size.width / (size.height * 0.6),
                          children: List.generate(
                            _searchController.text.trim().isNotEmpty
                                ? listProductsSearch.length
                                : products.length,
                            (index) => ChangeNotifierProvider.value(
                              value: _searchController.text.trim().isNotEmpty
                                  ? listProductsSearch[index]
                                  : products[index],
                              child: const FeedsWidget(),
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
