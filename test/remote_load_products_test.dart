import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockClientStub extends MockClient {
  MockClientStub() : super(_mockClientHandler);

  static Response _anyResponse({int statusCode = 200}) =>
      Response('', statusCode);
  static Response invalidResponse(int statusCode) =>
      _anyResponse(statusCode: statusCode);
  static Response validResponse(String body) => Response(body, 200);

  static var urls = [];
  static Exception? clientException;
  static Response? clientResponse;

  static Future<Response> _mockClientHandler(http.Request request) {
    urls.add(request.url);
    if (clientException != null) {
      throw clientException!;
    } else if (clientResponse != null) {
      return Future.value(clientResponse);
    }
    return Future.value(_anyResponse());
  }

  completeWith(Exception exception) {
    clientException = exception;
  }

  completeWithResponse(Response response) {
    clientResponse = response;
  }

  static void clear() {
    urls.clear();
    clientException = null;
    clientResponse = null;
  }
}

class RemoteLoaderSUT {
  final MockClientStub client;
  final RemoteProductsLoader loader;

  RemoteLoaderSUT(this.client, this.loader);
}

void main() {
  RemoteLoaderSUT _makeSUT() {
    final client = MockClientStub();
    final loader = RemoteProductsLoader(client);
    return RemoteLoaderSUT(client, loader);
  }

  dynamic tryLoadProducts(RemoteProductsLoader loader) async {
    var expectedError;
    try {
      await loader.loadProducts();
    } catch (error) {
      expectedError = error;
    }
    return expectedError;
  }

  tearDown(() {
    MockClientStub.clear();
  });

  test('init does not request data from end point', () async {
    _makeSUT();
    expect(MockClientStub.urls.isEmpty, true);
  });

  test('load requests data from end point', () async {
    final sut = _makeSUT();
    await tryLoadProducts(sut.loader);
    expect(MockClientStub.urls.length, 1);
  });

  test('load twice requests data from end point', () async {
    final sut = _makeSUT();
    await tryLoadProducts(sut.loader);
    await tryLoadProducts(sut.loader);
    expect(MockClientStub.urls.length, 2);
  });

  test('load delivers error on client error', () async {
    final sut = _makeSUT();
    final anyException = Exception();
    sut.client.completeWith(anyException);
    var expectedError = await tryLoadProducts(sut.loader);
    expect(expectedError, RemoteProductsLoaderErrors.connectivity);
  });

  test('load delivers error on non 200 HTTP Response', () async {
    final sut = _makeSUT();
    final samples = [199, 201, 300, 400, 500];
    for (int statusCode in samples) {
      sut.client
          .completeWithResponse(MockClientStub.invalidResponse(statusCode));
      var expectedError = await tryLoadProducts(sut.loader);
      expect(expectedError, RemoteProductsLoaderErrors.invalidData);
    }
  });

  test('load delivers error on 200 HTTP Response with invalid json', () async {
    final sut = _makeSUT();
    sut.client.completeWithResponse(MockClientStub.invalidResponse(200));
    var expectedError = await tryLoadProducts(sut.loader);
    expect(expectedError, RemoteProductsLoaderErrors.invalidData);
  });

  test('load delivers no products on 200 HTTP Response with empty json',
      () async {
    final sut = _makeSUT();
    final emptyResponse = MockClientStub.validResponse("{\"data\": []}");
    sut.client.completeWithResponse(emptyResponse);
    var expectedResult = await sut.loader.loadProducts();
    expect(expectedResult.data.isEmpty, true);
  });
}

enum RemoteProductsLoaderErrors { connectivity, invalidData }

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

class Products {
  List<Product> data;

  Products({required this.data});

  factory Products.fromJson(Map<String, dynamic> json) {
    List<Product> products = [];
    final data = json['data'];
    data.forEach((value) {
      products.add(Product.fromJson(value));
    });
    return Products(data: products);
  }
}

class Product {
  String sku;
  String name;
  int price;
  int taxRate;
  double taxedPrice;

  Product(
      {required this.sku,
      required this.name,
      required this.price,
      required this.taxRate,
      required this.taxedPrice});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      sku: json['sku'],
      name: json['name'],
      price: json['price'],
      taxRate: json['taxRate'],
      taxedPrice: json['taxedPrice']);
}
