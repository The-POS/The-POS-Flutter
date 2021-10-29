import 'package:flutter_test/flutter_test.dart';
import 'package:thepos/features/invoice/repositories/remote_store_invoice.dart';

import '../helpers/mock_client_stub.dart';
import 'helpers/remote_store_invoice_sut.dart';

void main() {
  RemoteStoreInvoiceSUT _makeSUT() {
    final MockClientStub client = MockClientStub();
    final RemoteStoreInvoice sut =
        RemoteStoreInvoice(client, Uri.http('domain', 'path'));
    return RemoteStoreInvoiceSUT(client, sut);
  }

  test('init does not post any data to the end point', () async {
    _makeSUT();
    expect(MockClientStub.requests.isEmpty, true);
  });
}
