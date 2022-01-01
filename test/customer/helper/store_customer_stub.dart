import 'package:thepos/features/customer/data/models/customer.dart';
import 'package:thepos/features/customer/data/serives/data_sources/remote_customer.dart';

class StoreCustomerStub extends RemoteCustomer {
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

  @override
  Future<List<Customer>> load() {
    // TODO: implement load
    throw UnimplementedError();
  }

}