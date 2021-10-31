import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';

class StoreInvoiceRepository extends StoreInvoice {
  StoreInvoiceRepository(
      {required this.isOnline, required this.remote, required this.local});

  final bool isOnline;
  final StoreInvoice remote;
  final StoreInvoice local;

  @override
  Future<Invoice> store(Invoice invoice) async {
    if (isOnline) {
      return remote.store(invoice);
    } else {
      return local.store(invoice);
    }
  }
}
