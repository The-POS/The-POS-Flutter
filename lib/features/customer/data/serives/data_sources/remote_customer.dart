import 'package:thepos/features/customer/data/models/customer.dart';

abstract class RemoteCustomer {
  Future<Customer> store(Customer customer);
  Future <List<Customer>> load();
}