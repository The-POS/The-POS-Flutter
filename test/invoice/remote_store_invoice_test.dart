import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/invoice/data/data_sources/api_invoice/remote_store_invoice.dart';
import 'package:thepos/features/invoice/data/data_sources/api_invoice/remote_store_invoice_error.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';

import '../helpers/mock_client_stub.dart';
import 'helpers/remote_store_invoice_sut.dart';
import 'helpers/shared_test_helper.dart';

void main() {
  RemoteStoreInvoiceSUT _makeSUT({String? token}) {
    final MockClientStub client = MockClientStub();
    final RemoteStoreInvoice sut =
        RemoteStoreInvoice(client, Uri.http('domain', 'path'), token);
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

    await await tryFunction(() => sut.remoteStoreInvoice.store(anyInvoice));

    expect(MockClientStub.requests.first.body, json.encode(anyJsonInvoice));
  });

  test('store add the correct header to the end point when token is null',
      () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();

    await await tryFunction(() => sut.remoteStoreInvoice.store(anyInvoice));

    expect(MockClientStub.requests.first.headers,
        <String, String>{'Content-Type': 'application/json; charset=utf-8'});
  });

  test('store add the correct header to the end point when token is available',
      () async {
    const String token = 'token';
    final RemoteStoreInvoiceSUT sut = _makeSUT(token: token);

    await await tryFunction(() => sut.remoteStoreInvoice.store(anyInvoice));

    expect(MockClientStub.requests.first.headers, <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    });
  });

  test('store delivers error on the client error', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();

    sut.client.completeWith(anyException);

    final dynamic error =
        await tryFunction(() => sut.remoteStoreInvoice.store(anyInvoice));

    expect(error, RemoteStoreInvoiceErrors.connectivity);
  });

  test('store delivers error on non 201 HTTP Response', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();
    final List<int> samples = <int>[199, 200, 300, 400, 500];
    for (final int statusCode in samples) {
      sut.client.completeWithResponse(
          MockClientStub.createResponse(statusCode, 'response'));
      final dynamic error =
          await tryFunction(() => sut.remoteStoreInvoice.store(anyInvoice));
      expect(error != null, true);
    }
  });

  test('store delivers duplicate client id error on 409 HTTP Response',
      () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();
    sut.client
        .completeWithResponse(MockClientStub.createResponse(409, 'response'));
    final dynamic error =
        await tryFunction(() => sut.remoteStoreInvoice.store(anyInvoice));
    expect(error, RemoteStoreInvoiceErrors.duplicateClientId);
  });

  test('store delivers not found error on 404 HTTP Response', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();
    sut.client
        .completeWithResponse(MockClientStub.createResponse(404, 'response'));
    final dynamic error =
        await tryFunction(() => sut.remoteStoreInvoice.store(anyInvoice));
    expect(error, RemoteStoreInvoiceErrors.notFound);
  });

  test('store delivers created invoice on 201 HTTP Response', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();

    final Invoice invoice = anyInvoice;
    final String response = jsonEncode(invoice.toJson());

    sut.client
        .completeWithResponse(MockClientStub.createResponse(201, response));

    final Invoice result = await sut.remoteStoreInvoice.store(invoice);

    expectInvoice(result, invoice);
  });
}
