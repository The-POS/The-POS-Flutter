import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/invoice/repositories/remote_store_invoice.dart';
import 'package:thepos/features/invoice/repositories/remote_store_invoice_error.dart';

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

    await sut.remoteStoreInvoice.store(anyJsonInvoice);

    expect(MockClientStub.requests.first.body, json.encode(anyJsonInvoice));
  });

  test('store delivers error on the client error', () async {
    final RemoteStoreInvoiceSUT sut = _makeSUT();

    sut.client.completeWith(anyException);

    final dynamic error =
        await tryFunction(() => sut.remoteStoreInvoice.store(anyJsonInvoice));

    expect(error, RemoteStoreInvoiceErrors.connectivity);
  });
}
