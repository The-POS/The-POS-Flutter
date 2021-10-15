import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  Response _anyResponse() => Response('', 200);
  var urls = [];

  Future<Response> _mockClientHandler(http.Request request) {
    urls.add(request.url);
    return Future.value(_anyResponse());
  }

  test('init does not request data from end point', () async {
    final client = MockClient(_mockClientHandler);
    RemoteProductsLoader(client);
    expect(urls.isEmpty, true);
  });
}

class RemoteProductsLoader {
  final http.Client _client;

  RemoteProductsLoader(this._client);

  loadProducts() async {
    final response = await _client.get(Uri.http('domain', 'path'));
  }
}
