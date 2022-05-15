import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/feed_items_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = "FeedsScreen";
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focus = FocusNode();
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
          text: "All Products",
          color: color,
          textSize: 24.0,
          isTilte: true,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                    setState(() {});
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
            isEmpty
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
                    children: List.generate(16, (index) => const FeedsWidget()),
                  ),
          ],
        ),
      ),
    );
  }
}
