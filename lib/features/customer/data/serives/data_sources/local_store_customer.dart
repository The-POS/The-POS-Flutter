import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:thepos/core/config.dart';
import 'package:thepos/core/preferences_utils.dart';
import 'package:thepos/features/customer/customer_cache_policy.dart';
import 'package:thepos/features/customer/data/models/customer.dart';

class LocalStoreCustomer  {
  LocalStoreCustomer({required this.hiveBox});

  final Box<Customer> hiveBox;

  Future<Customer> store(Customer customer) async {
    await hiveBox.put(customer.mobile_no, customer);
    return customer;
  }

  Future<List<Customer>> load() async {
    final bool isCacheExpired = await _isCacheExpired();
    if (isCacheExpired) {
      await hiveBox.deleteFromDisk();
      return <Customer>[];
    }
    final List<Customer> customers = hiveBox.values
        .map((Customer customer) => customer)
        .toList();
    return Future<List<Customer>>.value(customers);
  }
  Future<Iterable<int>> insertCustomers(List<Customer> customers) async {
    PreferenceUtils.setCacheTime(DateTime.now().millisecondsSinceEpoch);
    return hiveBox.addAll(customers);
  }

  Future<bool> _isCacheExpired() async {
    final int cachedProductTime = await PreferenceUtils.getCacheTime();
    if (cachedProductTime == null) {
      return false;
    }
    final DateTime cachedDateTime =
    DateTime.fromMillisecondsSinceEpoch(cachedProductTime);
    final CustomerCachePolicy cachePolicy = CustomerCachePolicy(
      customersCacheTimeIntervalInHours,
      cachedDateTime,
    );
    return cachePolicy.isExpired(currentDateTime: DateTime.now());
  }
}
