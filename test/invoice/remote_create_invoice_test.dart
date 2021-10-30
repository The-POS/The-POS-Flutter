import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/home/data/models/product.dart';
import 'package:thepos/features/invoice/models/invoice.dart';
import 'package:thepos/features/invoice/models/invoice_item.dart';
import 'package:thepos/features/invoice/repositories/remote_store_invoice.dart';
import 'package:thepos/features/invoice/repositories/remote_store_invoice_error.dart';

import '../helpers/mock_client_stub.dart';
import 'helpers/remote_store_invoice_sut.dart';

void main() {
  RemoteStoreInvoiceSUT _makeSUT() {
    final MockClientStub client = MockClientStub();
    final RemoteStoreInvoice sut =
        RemoteStoreInvoice(client, Uri.http('domain', 'path'));
    return RemoteStoreInvoiceSUT(client, sut);
  }

  dynamic tryStoreInvoice(
      RemoteStoreInvoice sut, Map<String, dynamic> body) async {
    dynamic expectedError;
    try {
      await sut.store(body);
    } catch (error) {
      expectedError = error;
    }
    return expectedError;
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
    final Product testProduct =
        Product(name: 'test name', sku: 'test sku', price: 4);
    const int testQuantity = 2;

    final Invoice testInvoice = Invoice(
      clientId: 0,
      items: <InvoiceItem>[
        InvoiceItem(product: testProduct, quantity: testQuantity)
      ],
    );

    await sut.remoteStoreInvoice.store(testInvoice.toJson());

    expect(
        MockClientStub.requests.first.body, json.encode(testInvoice.toJson()));
  });

  test('store delivers error on the client error', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();
    final Product testProduct =
        Product(name: 'test name', sku: 'test sku', price: 4);
    const int testQuantity = 2;

    final Invoice testInvoice = Invoice(
      clientId: 0,
      items: <InvoiceItem>[
        InvoiceItem(product: testProduct, quantity: testQuantity)
      ],
    );

    final Exception anyException = Exception();
    sut.client.completeWith(anyException);

    final dynamic error =
        await tryStoreInvoice(sut.remoteStoreInvoice, testInvoice.toJson());

    expect(error, RemoteStoreInvoiceErrors.connectivity);
  });
}
