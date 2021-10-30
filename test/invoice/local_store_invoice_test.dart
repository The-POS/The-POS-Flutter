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
    expectInvoice(result.first, invoice);
  });

  test('retrieve delivers an empty cache after delete the inserted invoice',
      () async {
    final Box<Map<String, dynamic>> hiveBox = await Hive.openBox('testBox');
    final LocalStoreInvoice localStoreInvoice =
        LocalStoreInvoice(hiveBox: hiveBox);

    final Invoice invoice = anyInvoice;
    await localStoreInvoice.store(invoice);

    await localStoreInvoice.delete(invoice);

    final List<Invoice> result = localStoreInvoice.retrieve();
    expect(result.isEmpty, true);
  });
}

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
