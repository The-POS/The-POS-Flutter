// ignore_for_file: always_specify_types

import 'dart:convert';

import 'package:get/get.dart';
import 'package:thepos/core/config.dart';
import 'package:thepos/features/home/data/models/category.dart';
import 'package:thepos/features/home/data/models/product.dart';

class HomeRemoteDataSource extends GetConnect {
  Future<List<Product>> getProducts() async {
    final response = await get('$apiUrl/products');

    return List<Product>.from(
        response.body["data"].map((d) => Product.fromJson(d)));
  }

  Future<List<Product>> getProductsByGroupId(int groupId) async {
    final response = await get('$apiUrl/products?groupId=$groupId');

    return List<Product>.from(
        response.body["data"].map((d) => Product.fromJson(d)));
  }

  Future<List<Category>> getProductsCategories() async {
    final response = await get(
      '$apiUrl2/product-categories',
    );
    return List<Category>.from(
      response.body["data"].map((d) => Category.fromJson(d)),
    );
  }
}
