import 'package:thepos/features/carts/data/datasources/store_customer.dart';
import 'package:thepos/features/carts/data/models/customer.dart';

class StoreCustomerStub extends StoreCustomer {
  StoreCustomerStub({this.result, this.error});

  final Customer? result;
  final Exception? error;

  @override
  Future<Customer> store(Customer customer) {
    if (error != null) {
      return Future<Customer>.error(error!);
    }
    return Future<Customer>.value(result);
  }
}