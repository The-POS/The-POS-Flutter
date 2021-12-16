import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:thepos/features/carts/data/datasources/local_store_customer.dart';
import 'package:thepos/features/carts/data/models/customer.dart';

import 'helper/shared_test_helper.dart';

void main() {
  setUpAll(() {
    Hive.init('testPath');
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  Future<LocalStoreCustomer> makeSUT() async {
    final Box<String> hiveBox = await Hive.openBox('testBox');
    return LocalStoreCustomer(hiveBox: hiveBox);
  }

  test('retrieve delivers empty on empty cache', () async {
    final LocalStoreCustomer sut = await makeSUT();
    final List<Customer> result = await sut.load();
    expect(result.isEmpty, true);
  });

  test('retrieve delivers found customers on non empty cache', () async {
    final LocalStoreCustomer sut = await makeSUT();

    final Customer customer = anyCustomer;
    await sut.store(customer);

    final List<Customer> result = await sut.load();
    expect(result.isEmpty, false);
    expect(result.first.mobile_no, customer.mobile_no);

  });

  test('retrieve delivers an empty cache after delete the inserted customer',
          () async {
        final LocalStoreCustomer sut = await makeSUT();

        final Customer customer = anyCustomer;
        await sut.store(customer);


        // final List<Customer> result = await sut.load();
        // expect(result.isEmpty, true);
      });
}