import 'dart:convert';

import 'package:thepos/core/init_app.dart';
import 'package:thepos/features/home/data/models/product.dart';

class HomeFakerDataSource {
  Future<List<Product>> getProducts() async {
    List<Product> list = [];

    for (int i = 0; i < 100; i++) {
      list.add(Product(
          name: faker.commerce.productName(),
          price: faker.datatype.number(max: 200).toDouble(),
          sku: faker.commerce.productName()));
    }
    return list;
  }

  Future<List<Product>> getProductsByGroupId(int groupId) async {
    List<Product> list = [];

    for (int i = 0; i < 100; i++) {
      list.add(Product(
          name: faker.commerce.productName(),
          price: faker.datatype.number(max: 200).toDouble(),
          sku: faker.commerce.productName()));
    }
    return list;
  }
}
