import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepos/features/invoice/repositories/remote_store_invoice_error.dart';

class RemoteStoreInvoice {
  RemoteStoreInvoice(this._client, this._url);

  final http.Client _client;
  final Uri _url;

  Future<http.Response> store(Map<String, dynamic> body) async {
    try {
      final http.Response response =
          await _client.post(_url, body: json.encode(body));
      return response;
    } catch (error) {
      return Future<http.Response>.error(RemoteStoreInvoiceErrors.connectivity);
    }
  }
}
