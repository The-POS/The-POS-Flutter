import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockClientStub extends MockClient {
  MockClientStub() : super(_mockClientHandler);

  static Response _anyResponse() => Response('', 200);

  static var urls = [];

  static Future<Response> _mockClientHandler(http.Request request) {
    urls.add(request.url);
    return Future.value(_anyResponse());
  }
}

void main() {
  tearDown(() {
    MockClientStub.urls.clear();
  });

  test('init does not request data from end point', () async {
    final client = MockClientStub();
    RemoteProductsLoader(client);
    expect(MockClientStub.urls.isEmpty, true);
  });

  test('load requests data from end point', () async {
    final client = MockClientStub();
    final loader = RemoteProductsLoader(client);
    await loader.loadProducts();
    expect(MockClientStub.urls.length, 1);
  });

  test('load twice requests data from end point', () async {
    final client = MockClientStub();
    final loader = RemoteProductsLoader(client);
    await loader.loadProducts();
    await loader.loadProducts();
    expect(MockClientStub.urls.length, 2);
  });
}

class RemoteProductsLoader {
  final http.Client _client;

  RemoteProductsLoader(this._client);

  Future loadProducts() {
    return _client.get(Uri.http('domain', 'path'));
  }
}
