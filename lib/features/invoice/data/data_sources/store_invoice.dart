import 'package:thepos/features/invoice/data/models/invoice.dart';

abstract class StoreInvoice {
  Future<Invoice> store(Invoice invoice);
}
