import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';

import 'invoice_loader.dart';

class InvoiceLoaderRemoteStoreDecorator extends InvoiceLoader {
  InvoiceLoaderRemoteStoreDecorator(this.decorate, this.storeInvoice);

  final InvoiceLoader decorate;
  final StoreInvoice storeInvoice;

  @override
  Future<List<Invoice>> load() async {
    final List<Invoice> invoices = await decorate.load();
    for (final Invoice invoice in invoices) {
      final Invoice result = await storeInvoice.store(invoice);
      await delete(result);
    }
    return decorate.load();
  }

  @override
  Future<Invoice> delete(Invoice invoice) {
    return decorate.delete(invoice);
  }
}
