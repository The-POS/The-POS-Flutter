import 'package:thepos/features/products/products_api/remote_products_loader.dart';

import '../../../helpers/mock_client_stub.dart';

class RemoteLoaderSUT {
  RemoteLoaderSUT(this.client, this.loader);

  final MockClientStub client;
  final RemoteProductsLoader loader;
}
