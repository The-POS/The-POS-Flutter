import 'package:flutter/material.dart';

import 'product_item_widget.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  ProductsWidgetState createState() => ProductsWidgetState();
}

class ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 8,
        ),
        children: List<ProductItemWidget>.generate(
            30, (int index) => const ProductItemWidget()),
      ),
    );
  }
}
