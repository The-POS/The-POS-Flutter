import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/invoice/models/invoice.dart';
import 'package:thepos/features/invoice/repositories/api_invoice/remote_store_invoice.dart';
import 'package:thepos/features/invoice/repositories/api_invoice/remote_store_invoice_error.dart';

import '../helpers/mock_client_stub.dart';
import 'helpers/remote_store_invoice_sut.dart';
import 'helpers/shared_test_helper.dart';

void main() {
  RemoteStoreInvoiceSUT _makeSUT() {
    final MockClientStub client = MockClientStub();
    final RemoteStoreInvoice sut =
        RemoteStoreInvoice(client, Uri.http('domain', 'path'));
    return RemoteStoreInvoiceSUT(client, sut);
  }

  tearDown(() {
    MockClientStub.clear();
  });

  test('init does not post any data to the end point', () {
    _makeSUT();
    expect(MockClientStub.requests.isEmpty, true);
  });

  test('store post the correct data to the end point', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();

    await await tryFunction(() => sut.remoteStoreInvoice.store(anyJsonInvoice));

    expect(MockClientStub.requests.first.body, json.encode(anyJsonInvoice));
  });

  test('store delivers error on the client error', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();

    sut.client.completeWith(anyException);

    final dynamic error =
        await tryFunction(() => sut.remoteStoreInvoice.store(anyJsonInvoice));

    expect(error, RemoteStoreInvoiceErrors.connectivity);
  });

  test('store delivers error on non 201 HTTP Response', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();
    final List<int> samples = <int>[199, 200, 300, 400, 500];
    for (final int statusCode in samples) {
      sut.client.completeWithResponse(
          MockClientStub.createResponse(statusCode, 'response'));
      final dynamic error =
          await tryFunction(() => sut.remoteStoreInvoice.store(anyJsonInvoice));
      expect(error != null, true);
    }
  });

  test('store delivers duplicate client id error on 409 HTTP Response',
      () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();
    sut.client
        .completeWithResponse(MockClientStub.createResponse(409, 'response'));
    final dynamic error =
        await tryFunction(() => sut.remoteStoreInvoice.store(anyJsonInvoice));
    expect(error, RemoteStoreInvoiceErrors.duplicateClientId);
  });

  test('store delivers not found error on 404 HTTP Response', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();
    sut.client
        .completeWithResponse(MockClientStub.createResponse(404, 'response'));
    final dynamic error =
        await tryFunction(() => sut.remoteStoreInvoice.store(anyJsonInvoice));
    expect(error, RemoteStoreInvoiceErrors.notFound);
  });

  test('store delivers created invoice on 201 HTTP Response', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();

    final Invoice invoice = anyInvoice;
    final Map<String, dynamic> body = invoice.toJson();
    final String response = jsonEncode(body);

    sut.client
        .completeWithResponse(MockClientStub.createResponse(201, response));

    final Invoice result = await sut.remoteStoreInvoice.store(body);

    expect(result.clientId, invoice.clientId);
    expect(result.items.length, invoice.items.length);
    expect(result.items.first.quantity, invoice.items.first.quantity);

    final Product resultFirstProduct = result.items.first.product;
    final Product expectedResultFirstProduct = invoice.items.first.product;

    expect(resultFirstProduct.sku, expectedResultFirstProduct.sku);
    expect(resultFirstProduct.name, expectedResultFirstProduct.name);
    expect(resultFirstProduct.taxRate, expectedResultFirstProduct.taxRate);
    expect(
        resultFirstProduct.taxedPrice, expectedResultFirstProduct.taxedPrice);
  });
}
