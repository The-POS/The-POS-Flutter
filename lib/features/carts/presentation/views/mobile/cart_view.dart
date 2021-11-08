import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'common/cart_app_bar.dart';
import 'common/cart_items_widget.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  CartViewState createState() => CartViewState();
}

class CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CartAppBar(),
      body: Column(
        children: <Widget>[
          _buildTopRow(),
          const Expanded(child: CartItemsWidget())
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          _buildElevatedButton('assets/svg/dots.svg'),
          const Spacer(),
          _buildElevatedButton('assets/svg/delete.svg'),
        ],
      ),
    );
  }

  ElevatedButton _buildElevatedButton(String assets) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: SvgPicture.asset(assets),
    );
  }
}
