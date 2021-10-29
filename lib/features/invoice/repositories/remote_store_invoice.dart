import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteStoreInvoice {
  RemoteStoreInvoice(this._client, this._url);

  final http.Client _client;
  final Uri _url;

  Future<http.Response> store(Map<String, dynamic> body) {
    return _client.post(_url, body: json.encode(body));
  }
}
