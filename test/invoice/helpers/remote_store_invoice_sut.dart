import 'package:thepos/features/invoice/data/data_sources/api_invoice/remote_store_invoice.dart';

import '../../helpers/mock_client_stub.dart';

class RemoteStoreInvoiceSUT {
  RemoteStoreInvoiceSUT(this.client, this.remoteStoreInvoice);

  final MockClientStub client;
  final RemoteStoreInvoice remoteStoreInvoice;
}
