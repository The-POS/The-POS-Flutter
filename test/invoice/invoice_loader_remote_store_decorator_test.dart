import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/invoice/data/data_sources/invoice_loader_remote_store_decorator.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice_item.dart';

import 'helpers/invoice_loader_stub_spy.dart';
import 'helpers/shared_test_helper.dart';
import 'helpers/store_invoice_spy.dart';
import 'helpers/store_invoice_stub.dart';

void main() {
  test(
      'load post all invoices to server using remote invoice store then remove them',
      () async {
    final List<Invoice> loaderResult = <Invoice>[
      createInvoice(1, <InvoiceItem>[anyInvoiceItem]),
      createInvoice(2, <InvoiceItem>[anyInvoiceItem]),
      createInvoice(3, <InvoiceItem>[anyInvoiceItem])
    ];

    final InvoiceLoaderStubSpy invoiceLoader =
        InvoiceLoaderStubSpy(loaderResult);
    final StoreInvoiceSpy storeInvoice = StoreInvoiceSpy();

    final InvoiceLoaderRemoteStoreDecorator loader =
        InvoiceLoaderRemoteStoreDecorator(invoiceLoader, storeInvoice);

    await loader.load();

    expect(loaderResult.length, storeInvoice.postedInvoices.length);
    expect(storeInvoice.postedInvoices.length,
        invoiceLoader.deletedInvoice.length);

    for (int i = 0; i <= loaderResult.length - 1; i++) {
      expectInvoice(loaderResult[i], storeInvoice.postedInvoices[i]);
      expectInvoice(
          storeInvoice.postedInvoices[i], invoiceLoader.deletedInvoice[i]);
    }
  });

  test('load does not delete invoice when store failed to post it server',
      () async {
    final List<Invoice> loaderResult = <Invoice>[
      createInvoice(1, <InvoiceItem>[anyInvoiceItem]),
      createInvoice(2, <InvoiceItem>[anyInvoiceItem]),
      createInvoice(3, <InvoiceItem>[anyInvoiceItem])
    ];

    final InvoiceLoaderStubSpy invoiceLoader =
        InvoiceLoaderStubSpy(loaderResult);
    final StoreInvoiceStub storeInvoice =
        StoreInvoiceStub(error: Exception('message'));

    final InvoiceLoaderRemoteStoreDecorator loader =
        InvoiceLoaderRemoteStoreDecorator(invoiceLoader, storeInvoice);

    await tryFunction(() => loader.load());

    expect(invoiceLoader.deletedInvoice.length, 0);
  });
}
