import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final orderModel = Provider.of<OrderModel>(context);
    var orderDate = orderModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context);
    final currentProduct = Provider.of<ProductsProvider>(context)
        .getProductById(id: orderModel.productId)
        .title;

    final Color color = Utils(context).getColor;
    final Size size = Utils(context).getScreenSize;
    return ListTile(
      title: TextWidget(
          text: '$currentProduct x${orderModel.quantity}',
          color: color,
          textSize: 18),
      trailing: TextWidget(text: orderDateToShow, color: color, textSize: 18),
      subtitle: Text("Paid: \$${orderModel.price}"),
      onTap: () => GlobalMethods.navigateTo(
          ctx: context, name: ProductDetailScreen.routeName),
      leading: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: FancyShimmerImage(
          width: size.width * 0.2,
          imageUrl: orderModel.imageUrl,
          boxFit: BoxFit.fill,
        ),
      ),
    );
  }
}
