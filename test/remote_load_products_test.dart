import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

class MockClientStub extends MockClient {
  MockClientStub() : super(_mockClientHandler);

  static Response _anyResponse({int statusCode = 200}) =>
      Response('', statusCode);
  static Response invalidResponse(int statusCode) =>
      _anyResponse(statusCode: statusCode);

  static var urls = [];
  static Exception? clientException;
  static Response? clientResponse;

  static Future<Response> _mockClientHandler(http.Request request) {
    urls.add(request.url);
    if (clientException != null) {
      throw clientException!;
    } else if (clientResponse != null) {
      return Future.value(clientResponse);
    }
    return Future.value(_anyResponse());
  }

  completeWith(Exception exception) {
    clientException = exception;
  }

  completeWithResponse(Response response) {
    clientResponse = response;
  }

  static void clear() {
    urls.clear();
    clientException = null;
    clientResponse = null;
  }
}

void main() {
  tearDown(() {
    MockClientStub.clear();
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
    var expectedError;
    try {
      await loader.loadProducts();
    } catch (error) {
      expectedError = error;
    }
    expect(expectedError, RemoteProductsLoaderErrors.connectivity);
  });

  test('load delivers error on non 200 HTTP Response', () async {
    final client = MockClientStub();
    final loader = RemoteProductsLoader(client);
    final samples = [199, 201, 300, 400, 500];
    for (int statusCode in samples) {
      client.completeWithResponse(MockClientStub.invalidResponse(statusCode));
      var expectedError;
      try {
        await loader.loadProducts();
      } catch (error) {
        expectedError = error;
      }
      expect(expectedError, RemoteProductsLoaderErrors.invalidData);
    }
  });
}

enum RemoteProductsLoaderErrors { connectivity, invalidData }

class RemoteProductsLoader {
  final http.Client _client;

  RemoteProductsLoader(this._client);

  Future loadProducts() async {
    try {
      final response = await _client.get(Uri.http('domain', 'path'));
      if (response.statusCode != 200) {
        return Future.error(RemoteProductsLoaderErrors.invalidData);
      }
    } catch (error) {
      return Future.error(RemoteProductsLoaderErrors.connectivity);
    }
  }
}
