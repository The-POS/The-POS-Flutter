
import 'package:thepos/features/carts/data/datasources/store_customer.dart';
import 'package:thepos/features/carts/data/models/customer.dart';

class CustomerRepository extends StoreCustomer {
  CustomerRepository(
      {required this.checkInternetConnectivity,
        required this.remote,
        required this.local});

  final Future<bool> Function() checkInternetConnectivity;
  final StoreCustomer remote;
  final StoreCustomer local;

  @override
  Future<Customer> store(Customer customer) async {
    final bool isOnline = await checkInternetConnectivity();
    if (isOnline) {
      return remote.store(customer);
    } else {
      return local.store(customer);
    }
  }
}
