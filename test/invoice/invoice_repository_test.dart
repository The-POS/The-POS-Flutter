import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice_item.dart';
import 'package:thepos/features/invoice/data/repositories/invoice_repository.dart';

import 'helpers/shared_test_helper.dart';
import 'helpers/store_invoice_stub.dart';

void main() {
  InvoiceRepository makeSUT(
      {required bool isOnline,
      required Invoice remoteResult,
      required Invoice localResult}) {
    final StoreInvoice remote = StoreInvoiceStub(result: remoteResult);
    final StoreInvoice local = StoreInvoiceStub(result: localResult);

    return InvoiceRepository(
      checkInternetConnectivity: () {
        return Future<bool>.value(isOnline);
      },
      remote: remote,
      local: local,
    );
  }

  test('store use remote on online state', () async {
    final Invoice remoteResult =
        createInvoice(1, <InvoiceItem>[anyInvoiceItem]);
    final Invoice localResult =
        createInvoice(2, <InvoiceItem>[anyInvoiceItem, anyInvoiceItem]);

    final InvoiceRepository sut = makeSUT(
      isOnline: true,
      remoteResult: remoteResult,
      localResult: localResult,
    );

    final Invoice result = await sut.store(anyInvoice);

    expectInvoice(result, remoteResult);
  });

  test('store use local on offline state', () async {
    final Invoice remoteResult =
        createInvoice(1, <InvoiceItem>[anyInvoiceItem]);
    final Invoice localResult =
        createInvoice(2, <InvoiceItem>[anyInvoiceItem, anyInvoiceItem]);

    final InvoiceRepository sut = makeSUT(
      isOnline: false,
      remoteResult: remoteResult,
      localResult: localResult,
    );

    final Invoice result = await sut.store(anyInvoice);

    expectInvoice(result, localResult);
  });
}
