import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';

class StoreInvoiceSpy extends StoreInvoice {
  List<Invoice> postedInvoices = <Invoice>[];

  @override
  Future<Invoice> store(Invoice invoice) {
    postedInvoices.add(invoice);
    return Future<Invoice>.value(invoice);
  }
}
