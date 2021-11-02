import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';

class StoreInvoiceStub extends StoreInvoice {
  StoreInvoiceStub({this.result, this.error});

  final Invoice? result;
  final Exception? error;

  @override
  Future<Invoice> store(Invoice invoice) {
    if (error != null) {
      return Future<Invoice>.error(error!);
    }
    return Future<Invoice>.value(result);
  }
}
