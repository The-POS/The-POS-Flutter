import 'package:thepos/features/carts/data/models/customer.dart';

abstract class StoreCustomer {
  Future<Customer> store(Customer customer);
}