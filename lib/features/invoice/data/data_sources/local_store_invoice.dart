import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:thepos/features/invoice/data/data_sources/store_invoice.dart';

import '../models/invoice.dart';
import 'invoice_loader.dart';

class LocalStoreInvoice extends StoreInvoice implements InvoiceLoader {
  LocalStoreInvoice({required this.hiveBox});

  final Box<String> hiveBox;

  @override
  Future<Invoice> store(Invoice invoice) async {
    await hiveBox.put(invoice.clientId, json.encode(invoice.toJson()));
    return invoice;
  }

  @override
  Future<List<Invoice>> load() {
    final List<Invoice> invoices = hiveBox.values
        .map((String invoice) => Invoice.fromJson(json.decode(invoice)))
        .toList();
    return Future<List<Invoice>>.value(invoices);
  }

  @override
  Future<Invoice> delete(Invoice invoice) async {
    await hiveBox.delete(invoice.clientId);
    return invoice;
  }
}
