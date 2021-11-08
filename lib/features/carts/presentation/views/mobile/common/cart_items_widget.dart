import 'package:flutter/material.dart';

import 'cart_item_widget.dart';

class CartItemsWidget extends StatelessWidget {
  const CartItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: 12,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1),
        itemBuilder: (BuildContext context, int index) => CartItemWidget(
          isFirstItem: index == 0,
          isLastItem: index == 11,
        ),
      ),
    );
  }
}
