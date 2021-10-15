import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepos/products_feature/products_model.dart';
import 'package:thepos/products_feature/remote_products_loader_errors.dart';

class RemoteProductsLoader {
  final http.Client _client;

  RemoteProductsLoader(this._client);

  Future<Products> loadProducts() async {
    try {
      final response = await _client.get(Uri.http('domain', 'path'));
      if (response.statusCode == 200) {
        return _tryParse(response.body);
      } else {
        return Future.error(RemoteProductsLoaderErrors.invalidData);
      }
    } catch (error) {
      return Future.error(RemoteProductsLoaderErrors.connectivity);
    }
  }

  Future<Products> _tryParse(String body) {
    try {
      return Future.value(Products.fromJson(jsonDecode(body)));
    } catch (error) {
      return Future.error(RemoteProductsLoaderErrors.invalidData);
    }
  }
}
