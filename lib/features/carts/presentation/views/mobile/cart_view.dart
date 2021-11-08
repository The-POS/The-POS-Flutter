import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thepos/features/carts/presentation/views/mobile/cart_list_view.dart';

import '../../widgets/mobile/cartItems/cart_items_widget.dart';
import '../../widgets/mobile/cart_app_bar.dart';
import '../../widgets/mobile/cart_list_floating_action_button.dart';

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
      floatingActionButton: CartListFloatingActionButton(
        onPressed: _showCartListView,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Column(
        children: <Widget>[
          _buildTopRow(),
          const Expanded(child: CartItemsWidget())
        ],
      ),
    );
  }

  void _showCartListView() {
    Get.defaultDialog(
      title: '',
      backgroundColor: Colors.white,
      barrierDismissible: true,
      radius: 5,
      content: const CartListView(
        selectedCartIndex: 0,
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
