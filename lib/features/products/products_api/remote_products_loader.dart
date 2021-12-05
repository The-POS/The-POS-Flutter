import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thepos/features/products/products_api/remote_products_loader_errors.dart';

import '../product.dart';
import '../products_loader.dart';
import 'api_products_model.dart';

class RemoteProductsLoader extends ProductsLoader {
  final Uri _url;
  final http.Client _client;

  RemoteProductsLoader(this._url, this._client);

  @override
  Future<List<Product>> loadProducts() async {
    try {
      final response = await _client.get(_url);
      if (response.statusCode == 200) {
        return _tryParse(response.body);
      } else {
        return Future.error(RemoteProductsLoaderErrors.invalidData);
      }
    } catch (error) {
      return Future.error(RemoteProductsLoaderErrors.connectivity);
    }
  }

  Future<List<Product>> _tryParse(String body) {
    try {
      return Future.value(Products.fromJson(jsonDecode(body)).data);
    } catch (error) {
      return Future.error(RemoteProductsLoaderErrors.invalidData);
    }
  }
}
