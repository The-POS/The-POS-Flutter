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

  Future<LocalStoreInvoice> makeSUT() async {
    final Box<Map<String, dynamic>> hiveBox = await Hive.openBox('testBox');
    return LocalStoreInvoice(hiveBox: hiveBox);
  }

  test('retrieve delivers empty on empty cache', () async {
    final LocalStoreInvoice sut = await makeSUT();
    final List<Invoice> result = sut.retrieve();
    expect(result.isEmpty, true);
  });

  test('retrieve delivers found invoices on non empty cache', () async {
    final LocalStoreInvoice sut = await makeSUT();

    final Invoice invoice = anyInvoice;
    await sut.store(invoice);

    final List<Invoice> result = sut.retrieve();
    expect(result.isEmpty, false);
    expectInvoice(result.first, invoice);
  });

  test('retrieve delivers an empty cache after delete the inserted invoice',
      () async {
    final LocalStoreInvoice sut = await makeSUT();

    final Invoice invoice = anyInvoice;
    await sut.store(invoice);
    await sut.delete(invoice);

    final List<Invoice> result = sut.retrieve();
    expect(result.isEmpty, true);
  });
}
