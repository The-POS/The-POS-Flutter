import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:thepos/features/invoice/models/invoice.dart';

import 'helpers/shared_test_helper.dart';

void main() {
  setUp(() {
    Hive.init('testPath');
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  test('retrieve delivers empty on empty cache', () async {
    final Box<Map<String, dynamic>> hiveBox = await Hive.openBox('testBox');
    final LocalStoreInvoice localStoreInvoice =
        LocalStoreInvoice(hiveBox: hiveBox);
    final List<Invoice> result = localStoreInvoice.retrieve();
    expect(result.isEmpty, true);
  });

  test('retrieve delivers found invoices on non empty cache', () async {
    final Box<Map<String, dynamic>> hiveBox = await Hive.openBox('testBox');
    final LocalStoreInvoice localStoreInvoice =
        LocalStoreInvoice(hiveBox: hiveBox);

    final Invoice invoice = anyInvoice;
    await localStoreInvoice.store(invoice);

    final List<Invoice> result = localStoreInvoice.retrieve();
    expect(result.isEmpty, false);
    expect(result.first.clientId, invoice.clientId);
    expect(
        result.first.items.first.product.sku, invoice.items.first.product.sku);
    expect(result.first.items.first.product.name,
        invoice.items.first.product.name);
    expect(result.first.items.first.product.price,
        invoice.items.first.product.price);
    expect(result.first.items.first.product.taxedPrice,
        invoice.items.first.product.taxedPrice);
    expect(result.first.items.first.product.taxRate,
        invoice.items.first.product.taxRate);
  });
}

class LocalStoreInvoice {
  LocalStoreInvoice({required this.hiveBox});

  final Box<Map<String, dynamic>> hiveBox;

  Future<Invoice> store(Invoice invoice) async {
    await hiveBox.add(invoice.toJson());
    return invoice;
  }

  List<Invoice> retrieve() {
    return hiveBox.values
        .map((Map<String, dynamic> json) => Invoice.fromJson(json))
        .toList();
  }
}
