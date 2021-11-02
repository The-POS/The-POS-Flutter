import 'package:flutter_test/flutter_test.dart';
import 'package:http/src/response.dart';
import 'package:thepos/features/products/product.dart';
import 'package:thepos/features/products/products_api/remote_products_loader.dart';
import 'package:thepos/features/products/products_api/remote_products_loader_errors.dart';

import '../../helpers/mock_client_stub.dart';
import 'helpers/remote_loader_sut.dart';

void main() {
  RemoteLoaderSUT _makeSUT() {
    final MockClientStub client = MockClientStub();
    final RemoteProductsLoader loader =
        RemoteProductsLoader(Uri.http('domain', 'path'), client);
    return RemoteLoaderSUT(client, loader);
  }

  dynamic tryLoadProducts(RemoteProductsLoader loader) async {
    dynamic expectedError;
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
    expect(MockClientStub.requests.isEmpty, true);
  });

  test('load requests data from end point', () async {
    final RemoteLoaderSUT sut = _makeSUT();
    await tryLoadProducts(sut.loader);
    expect(MockClientStub.requests.length, 1);
  });

  test('load twice requests data from end point', () async {
    final RemoteLoaderSUT sut = _makeSUT();
    await tryLoadProducts(sut.loader);
    await tryLoadProducts(sut.loader);
    expect(MockClientStub.requests.length, 2);
  });

  test('load delivers error on client error', () async {
    final RemoteLoaderSUT sut = _makeSUT();
    final Exception anyException = Exception();
    sut.client.completeWith(anyException);
    final dynamic expectedError = await tryLoadProducts(sut.loader);
    expect(expectedError, RemoteProductsLoaderErrors.connectivity);
  });

  test('load delivers error on non 200 HTTP Response', () async {
    final RemoteLoaderSUT sut = _makeSUT();
    final List<int> samples = <int>[199, 201, 300, 400, 500];
    for (final int statusCode in samples) {
      sut.client.completeWithResponse(
          MockClientStub.createResponse(statusCode, 'response'));
      final dynamic expectedError = await tryLoadProducts(sut.loader);
      expect(expectedError, RemoteProductsLoaderErrors.invalidData);
    }
  });

  test('load delivers error on 200 HTTP Response with invalid json', () async {
    final RemoteLoaderSUT sut = _makeSUT();
    sut.client.completeWithResponse(
        MockClientStub.createResponse(200, 'invalid json'));
    final dynamic expectedError = await tryLoadProducts(sut.loader);
    expect(expectedError, RemoteProductsLoaderErrors.invalidData);
  });

  test('load delivers no products on 200 HTTP Response with empty json',
      () async {
    final RemoteLoaderSUT sut = _makeSUT();
    final Response emptyResponse =
        MockClientStub.createResponse(200, '{"data": []}');
    sut.client.completeWithResponse(emptyResponse);
    final List<Product> expectedResult = await sut.loader.loadProducts();
    expect(expectedResult.isEmpty, true);
  });

  test('load delivers products on 200 HTTP Response json items', () async {
    final RemoteLoaderSUT sut = _makeSUT();
    final Response response = MockClientStub.createResponse(200,
        '{"data": [{"sku": "978020137962","name": "ean13 product","price": 10,"tax_rate": 15,"taxed_price": 11.5}]}');
    sut.client.completeWithResponse(response);
    final List<Product> expectedResult = await sut.loader.loadProducts();
    expect(expectedResult.length, 1);
    expect(expectedResult.first.sku, '978020137962');
    expect(expectedResult.first.name, 'ean13 product');
    expect(expectedResult.first.price, 10);
    expect(expectedResult.first.taxRate, 15);
    expect(expectedResult.first.taxedPrice, 11.5);
  });
}
