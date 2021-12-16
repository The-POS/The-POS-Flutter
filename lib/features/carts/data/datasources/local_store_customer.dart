import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:thepos/features/carts/data/datasources/store_customer.dart';
import 'package:thepos/features/carts/data/models/customer.dart';

class LocalStoreCustomer extends StoreCustomer  {
  LocalStoreCustomer({required this.hiveBox});

  final Box<String> hiveBox;

  @override
  Future<Customer> store(Customer customer) async {
    await hiveBox.put(customer.mobile_no, json.encode(customer.toJson()));
    return customer;
  }

  @override
  Future<List<Customer>> load() {
    final List<Customer> customers = hiveBox.values
        .map((String customer) => Customer.fromJson(json.decode(customer)))
        .toList();
    return Future<List<Customer>>.value(customers);
  }
}
