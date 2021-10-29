import 'package:thepos/features/products/products_api/remote_products_loader.dart';

import 'mock_client_stub.dart';

class RemoteLoaderSUT {
  final MockClientStub client;
  final RemoteProductsLoader loader;

  RemoteLoaderSUT(this.client, this.loader);
}
