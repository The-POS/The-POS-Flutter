import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:thepos/features/invoice/data/data_sources/local_store_invoice.dart';
import 'package:thepos/features/invoice/data/models/invoice.dart';

import 'helpers/shared_test_helper.dart';

void main() {
  setUpAll(() {
    Hive.init('testPath');
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  Future<LocalStoreInvoice> makeSUT() async {
    final Box<String> hiveBox = await Hive.openBox('testBox');
    return LocalStoreInvoice(hiveBox: hiveBox);
  }

  test('retrieve delivers empty on empty cache', () async {
    final LocalStoreInvoice sut = await makeSUT();
    final List<Invoice> result = await sut.load();
    expect(result.isEmpty, true);
  });

  test('retrieve delivers found invoices on non empty cache', () async {
    final LocalStoreInvoice sut = await makeSUT();

    final Invoice invoice = anyInvoice;
    await sut.store(invoice);

    final List<Invoice> result = await sut.load();
    expect(result.isEmpty, false);
    expectInvoice(result.first, invoice);
  });

  test('retrieve delivers an empty cache after delete the inserted invoice',
      () async {
    final LocalStoreInvoice sut = await makeSUT();

    final Invoice invoice = anyInvoice;
    await sut.store(invoice);
    await sut.delete(invoice);

    final List<Invoice> result = await sut.load();
    expect(result.isEmpty, true);
  });
}
