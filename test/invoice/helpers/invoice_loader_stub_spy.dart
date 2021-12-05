import 'package:thepos/features/invoice/data/data_sources/invoice_loader.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';

class InvoiceLoaderStubSpy extends InvoiceLoader {
  InvoiceLoaderStubSpy(this.results);
  final List<Invoice> results;

  List<Invoice> deletedInvoice = <Invoice>[];

  @override
  Future<List<Invoice>> load() {
    return Future<List<Invoice>>.value(results);
  }

  @override
  Future<Invoice> delete(Invoice invoice) {
    deletedInvoice.add(invoice);
    return Future<Invoice>.value(invoice);
  }
}
