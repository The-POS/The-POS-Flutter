import 'package:hive/hive.dart';
import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';

import '../models/invoice.dart';

class LocalStoreInvoice extends StoreInvoice {
  LocalStoreInvoice({required this.hiveBox});

  final Box<Map<String, dynamic>> hiveBox;

  @override
  Future<Invoice> store(Invoice invoice) async {
    await hiveBox.put(invoice.clientId, invoice.toJson());
    return invoice;
  }

  List<Invoice> retrieve() {
    return hiveBox.values
        .map((Map<String, dynamic> json) => Invoice.fromJson(json))
        .toList();
  }

  Future<Invoice> delete(Invoice invoice) async {
    await hiveBox.delete(invoice.clientId);
    return invoice;
  }
}
