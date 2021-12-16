import 'package:thepos/features/carts/data/datasources/customer_remote_data_source.dart';

import '../../helpers/mock_client_stub.dart';

class RemoteStoreCustomerSUT {
  RemoteStoreCustomerSUT(this.client, this.remoteStoreCustomer);

  final MockClientStub client;
  final CustomerRemoteDataSource remoteStoreCustomer;
}