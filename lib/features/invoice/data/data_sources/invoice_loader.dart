import 'package:thepos/features/invoice/data/models/invoice.dart';

abstract class InvoiceLoader {
  Future<List<Invoice>> load();

  Future<Invoice> delete(Invoice invoice);
}
