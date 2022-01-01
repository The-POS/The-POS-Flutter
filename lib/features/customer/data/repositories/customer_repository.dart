
import 'package:thepos/features/customer/data/models/customer.dart';
import 'package:thepos/features/customer/data/serives/data_sources/api_customer/customer_remote_data_source.dart';
import 'package:thepos/features/customer/data/serives/data_sources/local_store_customer.dart';
import 'package:thepos/features/customer/data/serives/data_sources/remote_customer.dart';

class CustomerRepository extends RemoteCustomer {
  CustomerRepository(
      {required this.checkInternetConnectivity,
        required this.remote,
        required this.local});

  final Future<bool> Function() checkInternetConnectivity;
  final CustomerRemoteDataSource remote;
  final LocalStoreCustomer local;


  @override
  Future<Customer> store(Customer customer) async {
    final bool isOnline = await checkInternetConnectivity();
    if (isOnline) {
      return remote.store(customer);
    } else {
      return local.store(customer);
    }
  }

  @override
  Future<List<Customer>> load() async {
    final List<Customer> customers = await local.load();
    if (customers.isNotEmpty) {
    return customers;
    } else {
      final List<Customer> customers = await remote.load();

      local.insertCustomers(customers);
      return customers;
    }
  }
}
