import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thepos/features/invoice/repositories/remote_store_invoice_error.dart';

class RemoteStoreInvoice {
  RemoteStoreInvoice(this._client, this._url);

  final http.Client _client;
  final Uri _url;

  Future<void> store(Map<String, dynamic> body) async {
    try {
      final http.Response response =
          await _client.post(_url, body: json.encode(body));
      if (response.statusCode == 201) {
        return;
      } else if (response.statusCode == 404) {
        return Future<void>.error(RemoteStoreInvoiceErrors.notFound);
      } else if (response.statusCode == 409) {
        return Future<void>.error(RemoteStoreInvoiceErrors.duplicateClientId);
      } else {
        return Future<void>.error(RemoteStoreInvoiceErrors.invalidData);
      }
    } catch (error) {
      return Future<void>.error(RemoteStoreInvoiceErrors.connectivity);
    }
  }
}
