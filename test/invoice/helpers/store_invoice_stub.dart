import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';

class StoreInvoiceStub extends StoreInvoice {
  StoreInvoiceStub(this._result);

  final Invoice _result;

  @override
  Future<Invoice> store(Invoice invoice) {
    return Future<Invoice>.value(_result);
  }
}
