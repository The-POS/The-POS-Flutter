import 'package:flutter/material.dart';
import 'package:thepos/features/carts/data/models/cart.dart';

import 'cart_item_widget.dart';

class CartItemsWidget extends StatelessWidget {
  const CartItemsWidget({Key? key, required this.cart}) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: cart.cartItems.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1),
        itemBuilder: (BuildContext context, int index) => CartItemWidget(
          quantity: cart.cartItems[index].quantity,
          productName: cart.cartItems[index].product.name,
          productPrice: cart.cartItems[index].product.price,
          isFirstItem: index == 0,
          isLastItem: index == cart.cartItems.length - 1,
        ),
      ),
    );
  }
}
