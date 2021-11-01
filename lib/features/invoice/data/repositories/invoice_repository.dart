import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';

class InvoiceRepository extends StoreInvoice {
  InvoiceRepository(
      {required this.checkInternetConnectivity,
      required this.remote,
      required this.local});

  final Future<bool> Function() checkInternetConnectivity;
  final StoreInvoice remote;
  final StoreInvoice local;

  @override
  Future<Invoice> store(Invoice invoice) async {
    final bool isOnline = await checkInternetConnectivity();
    if (isOnline) {
      return remote.store(invoice);
    } else {
      return local.store(invoice);
    }
  }
}
