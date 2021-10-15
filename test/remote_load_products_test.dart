import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockClientStub extends MockClient {
  MockClientStub() : super(_mockClientHandler);

  static Response _anyResponse() => Response('', 200);

  static var urls = [];
  static Exception? clientException;

  static Future<Response> _mockClientHandler(http.Request request) {
    urls.add(request.url);
    if (clientException != null) {
      throw clientException!;
    }
    return Future.value(_anyResponse());
  }

  completeWith(Exception exception) {
    clientException = exception;
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

  test('load delivers error on client error', () async {
    final client = MockClientStub();
    final loader = RemoteProductsLoader(client);
    final anyException = Exception();
    client.completeWith(anyException);
    Exception? expectedException;
    try {
      await loader.loadProducts();
    } catch (error) {
      expectedException = error as Exception?;
    } finally {
      expect(anyException, expectedException);
    }
  });
}

class RemoteProductsLoader {
  final http.Client _client;

  RemoteProductsLoader(this._client);

  Future loadProducts() async {
    try {
      await _client.get(Uri.http('domain', 'path'));
    } catch (error) {
      throw error;
    }
  }
}
