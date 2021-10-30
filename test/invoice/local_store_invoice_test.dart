import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:thepos/features/invoice/models/invoice.dart';
import 'package:thepos/features/invoice/repositories/local_invoice/local_store_invoice.dart';

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
