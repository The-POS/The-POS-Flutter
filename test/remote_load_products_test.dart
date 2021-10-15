import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockClientHelper {
  Response _anyResponse() => Response('', 200);

  var urls = [];

  Future<Response> _mockClientHandler(http.Request request) {
    urls.add(request.url);
    return Future.value(_anyResponse());
  }
}

void main() {
  MockClientHelper? mockClientHelper;

  setUp(() {
    mockClientHelper = MockClientHelper();
  });

  tearDown(() {
    mockClientHelper = null;
  });

  test('init does not request data from end point', () async {
    final client = MockClient(mockClientHelper!._mockClientHandler);
    RemoteProductsLoader(client);
    expect(mockClientHelper?.urls.isEmpty, true);
  });

  test('load requests data from end point', () async {
    final client = MockClient(mockClientHelper!._mockClientHandler);
    final loader = RemoteProductsLoader(client);
    await loader.loadProducts();
    expect(mockClientHelper?.urls.length, 1);
  });

  test('load twice requests data from end point', () async {
    final client = MockClient(mockClientHelper!._mockClientHandler);
    final loader = RemoteProductsLoader(client);
    await loader.loadProducts();
    await loader.loadProducts();
    expect(mockClientHelper?.urls.length, 2);
  });
}

class RemoteProductsLoader {
  final http.Client _client;

  RemoteProductsLoader(this._client);

  Future loadProducts() {
    return _client.get(Uri.http('domain', 'path'));
  }
}
