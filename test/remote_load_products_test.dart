import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:thepos/products_feature/products_api/remote_products_loader.dart';
import 'package:thepos/products_feature/products_api/remote_products_loader_errors.dart';

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
    expect(expectedResult.isEmpty, true);
  });

  test('load delivers products on 200 HTTP Response json items', () async {
    final sut = _makeSUT();
    final response = MockClientStub.validResponse(
        "{\"data\": [{\"sku\": \"978020137962\",\"name\": \"ean13 product\",\"price\": 10,\"tax_rate\": 15,\"taxed_price\": 11.5}]}");
    sut.client.completeWithResponse(response);
    var expectedResult = await sut.loader.loadProducts();
    expect(expectedResult.length, 1);
    expect(expectedResult.first.sku, '978020137962');
    expect(expectedResult.first.name, 'ean13 product');
    expect(expectedResult.first.price, 10);
    expect(expectedResult.first.taxRate, 15);
    expect(expectedResult.first.taxedPrice, 11.5);
  });
}
