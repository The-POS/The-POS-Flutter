import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thepos/features/carts/presentation/controllers/carts_controller.dart';
import 'package:thepos/features/carts/presentation/views/mobile/cart_list_view.dart';

import '../../widgets/mobile/cartItems/cart_items_widget.dart';
import '../../widgets/mobile/cart_app_bar.dart';
import '../../widgets/mobile/cart_list_floating_action_button.dart';
import '../../widgets/mobile/pay_button.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);

  final CartsController cartsController = Get.find<CartsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CartAppBar(),
        floatingActionButton: CartListFloatingActionButton(
          onPressed: _showCartListView,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: _buildBody(),
      ),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _buildTopRow(),
          Expanded(
            child: CartItemsWidget(
              cart:
                  cartsController.listCarts[cartsController.selectedCart.value],
              onTapCartItem: (int index) => cartsController.editCartItem(index),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PayButton(
              isLoading: cartsController.isPayLoading.value,
              invoiceTotal: cartsController.invoiceTotal,
              onPressed: () => cartsController.pay(),
            ),
          ),
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
      content: Obx(
        () => CartListView(
          selectedCartIndex: cartsController.selectedCart.value,
          onSelectCart: (int selectIndex) {
            cartsController.changeCart(selectIndex);
            Get.back();
          },
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          _buildElevatedButton(
            assets: 'assets/svg/dots.svg',
            onPressed: () {},
          ),
          const Spacer(),
          _buildElevatedButton(
            assets: 'assets/svg/delete.svg',
            onPressed: () => cartsController.clearCarts(),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildElevatedButton(
      {required String assets, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: SvgPicture.asset(assets),
    );
  }
}
