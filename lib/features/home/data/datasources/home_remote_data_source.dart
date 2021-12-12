// ignore_for_file: always_specify_types

import 'package:get/get.dart';
import 'package:thepos/core/config.dart';
import 'package:thepos/features/home/data/models/category.dart';
import 'package:thepos/features/home/data/models/product.dart';

class HomeRemoteDataSource extends GetConnect {
  HomeRemoteDataSource({this.token});

  final String? token;

  Future<List<Product>> getProducts() async {
    final Map<String, String>? headers =
        token == null ? null : {'Authorization': 'Bearer $token'};
    final response = await get('$apiUrl/products', headers: headers);
    return List<Product>.from(
        response.body["data"].map((d) => Product.fromJson(d)));
  }

  Future<List<Product>> getProductsByGroupId(int groupId) async {
    final response = await get('$apiUrl/products?groupId=$groupId');

    return List<Product>.from(
        response.body["data"].map((d) => Product.fromJson(d)));
  }

  Future<List<Category>> getProductsCategories() async {
    final Map<String, String>? headers =
        token == null ? null : {'Authorization': 'Bearer $token'};
    final response = await get(
      '$apiUrl/product-categories',
      headers: headers,
    );
    return List<Category>.from(
      response.body["data"].map((d) => Category.fromJson(d)),
    );
  }
}
