import 'package:flutter/material.dart';
import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/product.dart';

import 'product_item_widget.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget(
      {Key? key, required this.products, required this.onTapProduct})
      : super(key: key);

  final List<Product> products;
  final Function(Product product) onTapProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 8,
        children: products
            .map(
              (Product product) => GestureDetector(
                onTap: () {
                  onTapProduct(product);
                },
                child: ProductItemWidget(
                  productName: product.name,
                  productImage: faker.image.loremPicsum.image(),
                  productPrice: product.price,
                  productSalePrice: product.salePrice,
                  product: product,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
