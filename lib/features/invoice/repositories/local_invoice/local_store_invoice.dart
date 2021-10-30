import 'package:hive/hive.dart';
import 'package:thepos/features/invoice/models/invoice.dart';

class LocalStoreInvoice {
  LocalStoreInvoice({required this.hiveBox});

  final Box<Map<String, dynamic>> hiveBox;

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
